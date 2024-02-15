import 'package:flutter/material.dart';

void successMessageFunc(cntxt, msg) {
  showDialog(
      context: cntxt,
      builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close',
                        style: TextStyle(
                          color: Colors.black,
                        ))),
              ],
              content: Text(msg,
                  style: TextStyle(
                    color: Colors.black,
                  )),
              buttonPadding: EdgeInsets.only(top: 20),
              backgroundColor: Color.fromARGB(255, 255, 115, 0)));
}
