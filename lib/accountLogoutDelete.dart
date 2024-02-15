import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/navigation.dart';
import 'package:fyp2/successMessage.dart';
import 'package:http/http.dart';

void confirmLogoutDelete(cntxt, ttl, msg, scn) {
  showDialog(
      context: cntxt,
      builder: (context) => AlertDialog(
          title: Text(ttl, style: const TextStyle(color: Colors.black)),
          content: Text(msg,
              style: const TextStyle(
                color: Colors.black,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(cntxt);
                  (scn == 'd')
                      ? deleteAccount(cntxt)
                      : {
                          token = '',
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage())),
                          successMessageFunc(cntxt, 'Logout Successfully')
                        };
                },
                child: const Text('Yes',
                    style: TextStyle(
                      color: Colors.black54,
                    ))),
            TextButton(
                onPressed: () {
                  Navigator.pop(cntxt);
                },
                child: const Text('No',
                    style: TextStyle(
                      color: Colors.black,
                    )))
          ],
          buttonPadding: const EdgeInsets.only(top: 20),
          backgroundColor: const Color.fromARGB(255, 255, 115, 0)));
}

void deleteAccount(cntxt) async {
  Response response =
      await delete(Uri.parse(liveURL + 'api/deleteAccountByUser?token=$token'));
  if (response.statusCode == 200) {
    token = '';
    Navigator.push(
        cntxt, MaterialPageRoute(builder: (context) => MyHomePage()));
    successMessageFunc(cntxt, 'Account Deleted Successfully');
  } else {
    var body = jsonDecode(response.body.toString());
    showErrorMessage(cntxt, body['message']);
  }
}

void showErrorMessage(cntxt, msg) {
  SnackBar snackBarMessage = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.red[200],
  );
  ScaffoldMessenger.of(cntxt).showSnackBar(snackBarMessage);
}
