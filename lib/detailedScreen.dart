import 'package:flutter/material.dart';
import 'package:fyp2/chat.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedScreen extends StatefulWidget {
  var dataMap;
  DetailedScreen({Key? myKey, this.dataMap}) : super(key: myKey);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  void getListById() async {
    Response response = await get(Uri.parse(liveURL +
        'api/fetchActiveListById?listId=' +
        widget.dataMap['_id'].toString()));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var path = data['data']['userId']['phoneNumber'].toString();
      launchUrl(await Uri(scheme: 'tel', path: path));
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
                          Text('USD ' + widget.dataMap['price'].toString(),
                              style: TextStyle(fontSize: 25)),
                          ElevatedButton(
                              onPressed: () async {
                                getListById();
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
                                      Color.fromARGB(255, 241, 219, 201),
                                  foregroundColor: Colors.black)),
                          ElevatedButton(
                              onPressed: () {
                                if (token == '') {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('Close',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ))),
                                              TextButton(
                                                onPressed: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LogInScreen())),
                                                child: Text('Log in',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              )
                                            ],
                                            title: Text('Log in',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                )),
                                            content: Text(
                                                'Please Log in, to continue!',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                )),
                                            buttonPadding:
                                                EdgeInsets.only(top: 20),
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 115, 0),
                                          ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen()));
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.chat),
                                  Text('Chat'),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 115, 0),
                                  foregroundColor: Colors.black))
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
                        Row(children: [
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
                                return CircularProgressIndicator();
                              } else {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 241, 219, 201),
                                    child: Icon(Icons.person,
                                        color:
                                            Color.fromARGB(255, 255, 115, 0)),
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
        ));
  }
}
