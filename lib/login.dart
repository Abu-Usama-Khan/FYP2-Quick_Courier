import 'package:flutter/material.dart';
import 'package:fyp2/Navigation.dart';
import 'signup.dart';
import 'globalVar.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showSuccessMessage(message) {
    SnackBar snackBarMessage = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
  }

  void showErrorMessage(message) {
    SnackBar snackBarMessage = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[200],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
  }

  void logInAPi(String email, password) async {
    Response response = await post(Uri.parse(liveURL + 'api/userSignIn'),
        body: {'emailAddress': email, 'password': password});
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      id = body['data']['_id'];
      token = body['token'];
      showSuccessMessage('Login Successfully!');
      Timer(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      });
    } else {
      showErrorMessage(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: 500,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.03),
          child: const Text('Login', style: TextStyle(fontSize: 40)),
        ),
        SizedBox(
            width: width * 0.85,
            height: height * 0.08,
            child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: AutofillHints.email,
                    hintText: 'Enter your email',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(242, 140, 40, 5)),
                    border: UnderlineInputBorder()),
                style: const TextStyle(fontSize: 25))),
        SizedBox(
            width: width * 0.85,
            height: height * 0.08,
            child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: AutofillHints.password,
                    hintText: 'Enter your password',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(242, 140, 40, 5)),
                    border: UnderlineInputBorder()),
                style: const TextStyle(fontSize: 25))),
        Padding(
            padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
            child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(242, 140, 40, 5)),
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  logInAPi(emailController.text.toString(),
                      passwordController.text.toString());
                })),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
              child: Text(
            'Donot have Account?',
            style: TextStyle(color: Colors.white),
          )),
          GestureDetector(
              child: const Text(' Sign Up'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen())))
        ]),
      ]),
    )));
  }
}
