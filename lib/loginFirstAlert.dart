import 'package:flutter/material.dart';
import 'package:fyp2/login.dart';

alertBox(cntxt) {
    showDialog(
        context: cntxt,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close',
                        style: TextStyle(
                          color: Colors.black54,
                        ))),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  },
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
              content: Text('Please Log in, to continue!',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              buttonPadding: EdgeInsets.only(top: 20),
              backgroundColor: Color.fromARGB(255, 255, 115, 0),
            ));
  }