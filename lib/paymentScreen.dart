import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/navigation.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  var baseCtry;
  var baseCty;
  var destCtry;
  var destCty;
  var date;
  var destLoc;
  var desc;
  var price;
  PaymentScreen(
      {Key? mykey,
      this.baseCtry,
      this.baseCty,
      this.destCtry,
      this.destCty,
      this.date,
      this.destLoc,
      this.desc,
      this.price})
      : super(key: mykey);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController crdHldrNameController = TextEditingController();
  TextEditingController crdNumController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  void showSuccessMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void addCardApi(
      String bc, bci, dc, dci, dt, dl, dsc, prc, chn, cn, em, ey, cvc) async {
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
      addListApi(bc, bci, dci, dt, dl, dsc, prc);
    } else {
      showErrorMessage(body['message']);
    }
  }

  void addListApi(String bc, bci, dci, dt, dl, dsc, prc) async {
    Response response =
        await post(Uri.parse(liveURL + 'api/insertList?token=$token'), body: {
      "baseCountry": bc,
      "baseCity": bci,
      "destinationCountry": userCountry,
      "destinationCity": dci,
      "receivingDate": dt,
      "destinationLocation": dl,
      "description": dsc,
      'price': prc
    });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      showSuccessMessage('List has been Added Successfully!');
      Timer(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      });
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
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: TextField(
                      controller: expDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Expire Date',
                        hintText: "mm/yyyy",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 152, 152, 152),
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      List expDate =
                          expDateController.text.toString().split('/');
                      var expMonth = expDate[0];
                      var expYear = expDate[1];
                      addCardApi(
                          widget.baseCtry,
                          widget.baseCty,
                          widget.destCtry,
                          widget.destCty,
                          widget.date,
                          widget.destLoc,
                          widget.desc,
                          widget.price,
                          crdHldrNameController.text.toString(),
                          crdNumController.text.toString(),
                          expMonth,
                          expYear,
                          cvcController.text.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 115, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust the border radius
                      ),
                    ),
                    child: const Text(
                      "Pay",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  )
                ],
              )),
        ));
  }
}
