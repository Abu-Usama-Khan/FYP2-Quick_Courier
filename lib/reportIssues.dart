import 'package:flutter/material.dart';
import 'package:fyp2/successMessage.dart';
import 'globalVar.dart';
import 'package:http/http.dart';
import 'dart:convert';

class repIssue extends StatefulWidget {
  const repIssue({super.key});

  @override
  State<repIssue> createState() => _repIssueState();
}

class _repIssueState extends State<repIssue> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController complainController = TextEditingController();

  void showErrorMessage(message) {
    SnackBar snackBarMessage = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[200],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
  }

  void repIssueAPI(String sub, comp) async {
    Response response = await post(
        Uri.parse(liveURL + 'api/insertIssue?token=' + token),
        body: {'subject': sub, 'complain': comp});
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context);
      successMessageFunc(context, 'Issue has been Reported!');
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
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SizedBox(
          width: width * 0.85,
          height: height * 0.85,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.1),
              child: Text(
                'Report an Issue',
                style: TextStyle(fontSize: 40),
              ),
            ),
            TextFormField(
                controller: subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(242, 140, 40, 5), fontSize: 20),
                  border: UnderlineInputBorder(),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 25)),
            TextFormField(
                controller: complainController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Complain',
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(242, 140, 40, 5), fontSize: 20),
                  border: UnderlineInputBorder(),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 25)),
            Padding(
                padding:
                    EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
                child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 255, 115, 0)),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                      fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            'Submit Issue',
                            style: TextStyle(fontSize: 20),
                          ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      repIssueAPI(subjectController.text.toString(),
                          complainController.text.toString());
                    }))
          ]),
        )),
      ),
    );
  }
}
