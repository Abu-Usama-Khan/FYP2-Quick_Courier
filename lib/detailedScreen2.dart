import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/successMessage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedScreen2 extends StatefulWidget {
  final dataMap;
  DetailedScreen2({Key? myKey, this.dataMap}) : super(key: myKey);

  @override
  State<DetailedScreen2> createState() => _DetailedScreen2State();
}

class _DetailedScreen2State extends State<DetailedScreen2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  void showErrorMessage(message) {
    SnackBar snackBarMessage = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[200],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
  }

  void getListById(a) async {
    Response response = await get(Uri.parse(liveURL +
        'api/fetchActiveListById?listId=' +
        widget.dataMap['_id'].toString()));
    if (response.statusCode == 200 && a == 'c') {
      var data = jsonDecode(response.body);
      var path = data['data']['userId']['phoneNumber'].toString();
      launchUrl(await Uri(scheme: 'tel', path: path));
    } else if (response.statusCode == 200 && a == 's') {
      var data = jsonDecode(response.body);
      var path = data['data']['userId']['phoneNumber'].toString();
      launchUrl(await Uri(scheme: 'sms', path: path + '?body: Hi!'));
    } else {
      var path = '';
      launchUrl(await Uri(scheme: 'tel', path: path));
    }
  }

  Future getListById2() async {
    Response response = await get(Uri.parse(liveURL +
        'api/fetchActiveListById?listId=' +
        widget.dataMap['_id'].toString()));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['data']['userId'];
    } else {
      return {};
    }
  }

  Future postPayment(String email, accNum) async {
    Response response = await post(
        Uri.parse(liveURL + 'api/createPayment?token=' + token),
        body: {
          'listId': widget.dataMap['_id'].toString(),
          'emailAddress': email,
          'accountNumber': accNum
        });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      successMessageFunc(context, 'Payment Sent Succesfully');
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(body['message']);
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 115, 0),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.05, height * 0.075, width * 0.05, height * 0.03),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: const Image(
                      image: AssetImage('assets/images/download2.jpg'),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: height * 0.02, bottom: height * 0.02),
                    padding: EdgeInsets.only(
                        left: width * 0.02, right: width * 0.02),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PKR ' + widget.dataMap['price'].toString(),
                            style: TextStyle(fontSize: 25)),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  getListById('s');
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.message),
                                    Text('SMS'),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 241, 219, 201),
                                    foregroundColor: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    getListById('c');
                                    //print(path);
                                    //launchUrl(await Uri(scheme: 'tel', path: path));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone),
                                      Text('Call'),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 115, 0),
                                      foregroundColor: Colors.black)),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(
                      bottom: height * 0.02, left: width * 0.02),
                  width: width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 219, 201),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: const Text('Details',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 115, 0),
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        height: 2)),
                                Text('To',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        height: 2)),
                                Text('Destination Address:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        height: 2)),
                                Text('Recieving Till Date:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        height: 2))
                              ]),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      widget.dataMap['baseCity'].toString() +
                                          ' (' +
                                          widget.dataMap['baseCountry']
                                              .toString() +
                                          ')',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 2)),
                                  Text(
                                      widget.dataMap['destinationCity']
                                              .toString() +
                                          ' (' +
                                          widget.dataMap['destinationCountry']
                                              .toString() +
                                          ')',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 2)),
                                  Text(
                                      widget.dataMap['destinationLocation']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 2)),
                                  Text(
                                      widget.dataMap['receivingDate']
                                          .split('T')[0]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 2))
                                ]),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  padding: EdgeInsets.only(left: width * 0.02),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01, bottom: height * 0.01),
                        child: Text('Description',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 115, 0),
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(widget.dataMap['description'].toString(),
                          style: TextStyle(
                              color: Colors.black, fontSize: 15, height: 1.5))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(
                          color: Color.fromARGB(255, 255, 115, 0),
                          thickness: height * 0.003),
                      FutureBuilder(
                          future: getListById2(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                    width: width * 0.1,
                                    height: width * 0.1,
                                    child: const CircularProgressIndicator()),
                              );
                            } else {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 241, 219, 201),
                                  child: Icon(Icons.person,
                                      color: Color.fromARGB(255, 255, 115, 0)),
                                ),
                                title: Text(snapshot.data['fullName'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: height * 0.5,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.85,
                        child: Column(children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val != null) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                    return null;
                                  } else {
                                    return 'Enter a valid email address';
                                  }
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: AutofillHints.email,
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(242, 140, 40, 5),
                                    fontSize: 20),
                                border: UnderlineInputBorder(),
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 25)),
                          TextFormField(
                              controller: accountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'account number',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(242, 140, 40, 5),
                                    fontSize: 20),
                                border: UnderlineInputBorder(),
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 25))
                        ]),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            postPayment(emailController.text.toString(),
                                accountController.text.toString());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 255, 115, 0)),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : const Text('Send Payment')),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.05, top: height * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 241, 219, 201)),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                child: const Text('Close'))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: width * 0.6,
          height: height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromARGB(200, 255, 115, 0),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.17, vertical: 15),
            child: Text(
              'Release Payment',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        /***style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Color.fromARGB(255, 255, 115, 0))***/
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
