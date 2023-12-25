import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:http/http.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  Future getTerms() async {
    Response response = await get(
        Uri.parse(liveURL + 'api/getTermsAndCondition?token=' + token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data']['content'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.05,
                bottom: height * 0.1,
                left: width * 0.05,
                right: width * 0.05),
            child: FutureBuilder(
                future: getTerms(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return Text(snapshot.data.toString());
                  }
                }),
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontSize: 20)),
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 255, 115, 0)),
                foregroundColor: MaterialStatePropertyAll(Colors.black),
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(100)),
              ))
        ],
      ),
    );
  }
}
