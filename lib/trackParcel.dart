import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TrackParcel extends StatefulWidget {
  const TrackParcel({super.key});

  @override
  State<TrackParcel> createState() => _TrackParcelState();
}

class _TrackParcelState extends State<TrackParcel> {
  TextEditingController phoneController = TextEditingController();
  String name = '';
  String phnNum = '';
  String state = '';
  String city = '';
  String lastUpdated = '';
  bool isLoading = false;

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void getTracking(String num) async {
    Response response = await get(Uri.parse(
        liveURL + '/api/getUserProfile?phoneNumber=$num&token=$token'));
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        phnNum = num;
        name = body['data']['fullName'];
        state = body['data']['state'];
        city = body['data']['city'];
        lastUpdated = body['data']['lastUpdateLocation'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        appBar: AppBar(title: Text('Track Parcel')),
        body: phnNum == ''
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width * 0.85,
                        height: height * 0.09,
                        child: IntlPhoneField(
                          controller: phoneController,
                          showDropdownIcon: false,
                          countries: [
                            Country(
                              name: "Pakistan",
                              nameTranslations: {
                                "sk": "Pakistan",
                              },
                              flag: "🇵🇰",
                              code: "PK",
                              dialCode: "92",
                              minLength: 10,
                              maxLength: 10,
                            ),
                          ],
                          initialCountryCode: 'PK',
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(242, 140, 40, 5),
                                fontSize: 20),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: height * 0.05),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            getTracking(phoneController.text.toString());
                          },
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                                  'Track',
                                  style: TextStyle(fontSize: 25),
                                ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.85, height * 0.01),
                              backgroundColor: Color.fromARGB(255, 255, 115, 0),
                              foregroundColor: Colors.black),
                        ))
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  width: width * 0.9,
                  height: height * 0.9,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text('State:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text('City:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text('Last Updated:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18))
                        ],
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(state,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(city,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                              lastUpdated.substring(0, 10) +
                                  ' (' +
                                  lastUpdated.substring(11, 19) +
                                  ')',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18))
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
