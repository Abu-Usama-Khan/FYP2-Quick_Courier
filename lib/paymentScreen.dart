import 'dart:async';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/navigation.dart';
import 'package:fyp2/successMessage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  final fromCity;
  final toCity;
  final date;
  final destLoc;
  final desc;
  final price;
  final weight;
  PaymentScreen(
      {Key? mykey,
      this.fromCity,
      this.toCity,
      this.date,
      this.destLoc,
      this.desc,
      this.price,
      this.weight})
      : super(key: mykey);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController crdHldrNameController = TextEditingController();
  TextEditingController crdNumController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  String? recDate;
  bool isLoading = false;
  var selectedDate;
  String text = 'Expiry Date';
  var expMonth;
  var expYear;

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void addCardApi(
      String bci, dci, dt, dl, dsc, prc, wt, chn, cn, em, ey, cvc) async {
    Response response = await post(
        Uri.parse(liveURL + 'api/createPayment?token=$token'),
        body: {
          "cardHolderName": chn,
          "cardNumber": cn,
          "expMonth": em,
          "expYear": ey,
          "cvc": cvc
        });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      addListApi(bci, dci, dt, dl, dsc, prc, wt);
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(body['message']);
    }
  }

  void addListApi(String bci, dci, dt, dl, dsc, prc, wt) async {
    Response response =
        await post(Uri.parse(liveURL + 'api/insertList?token=$token'), body: {
      "baseCountry": 'Pakistan',
      "baseCity": bci,
      "destinationCountry": 'Pakistan',
      "destinationCity": dci,
      "receivingDate": dt,
      "destinationLocation": dl,
      "description": dsc,
      'price': prc,
      'weight': wt
    });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      successMessageFunc(context, 'List has been Added Successfully!');
    } else {
      showErrorMessage(body['message']);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Card'),
        ),
        body: Center(
          child: Container(
              width: width * 0.85,
              height: height * 0.85,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.05, bottom: height * 0.03),
                    child: const Text("Card Details",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 115, 0))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: TextField(
                      controller: crdHldrNameController,
                      decoration: const InputDecoration(
                        labelText: 'Card Holder Name',
                        hintText: "Muhammad Ali",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 152, 152, 152),
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: TextField(
                      controller: crdNumController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        hintText: "XXXX XXXX XXXX XXXX",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 152, 152, 152),
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: TextField(
                      controller: cvcController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "CVC Number",
                        hintText: "XXX or XXXX",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 152, 152, 152),
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          selectedDate = await showMonthPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                          );
                          List expDate = selectedDate.toString().split('-');
                          expMonth = expDate[1];
                          expYear = expDate[0];
                          setState(() {
                            text = expMonth + '/' + expYear;
                          });
                        },
                        child: Text(text, style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  Container(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      if (crdHldrNameController.text.toString() != '' &&
                          crdNumController.text.toString() != '' &&
                          cvcController.text.toString() != '') {
                        if (expMonth != null && expYear != null) {
                          addCardApi(
                              widget.fromCity,
                              widget.toCity,
                              widget.date,
                              widget.destLoc,
                              widget.desc,
                              widget.price,
                              widget.weight,
                              crdHldrNameController.text.toString(),
                              crdNumController.text.toString(),
                              expMonth,
                              expYear,
                              cvcController.text.toString());
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          showErrorMessage('Select Expiry Date');
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        showErrorMessage('All fields are required');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 115, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust the border radius
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Pay",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                  )
                ],
              )),
        ));
  }
}
