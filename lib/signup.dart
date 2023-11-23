import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'navigation.dart';
import 'login.dart';
import 'globalVar.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController =
      TextEditingController(text: 'Pakistan');
  TextEditingController phoneController = TextEditingController();

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

  void signUpAPI(String name, email, password, country, phone) async {
    Response response =
        await post(Uri.parse(liveURL + 'api/userSignUp'), body: {
      'emailAddress': email,
      'phoneNumber': phone,
      'fullName': name,
      'password': password,
      'country': country
    });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      userCountry = country;
      id = body['data']['_id'];
      token = body['token'];
      showSuccessMessage('Sign up Successfully!');
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
            child: const Text('Sign Up!', style: TextStyle(fontSize: 40)),
          ),
          SizedBox(
              width: width * 0.85,
              height: height * 0.08,
              child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: AutofillHints.name,
                      hintText: 'Full Name',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(242, 140, 40, 5)),
                      border: UnderlineInputBorder()),
                  style: const TextStyle(fontSize: 25))),
          SizedBox(
              width: width * 0.85,
              height: height * 0.08,
              child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: AutofillHints.email,
                      hintText: 'Email Address',
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
                      hintText: 'Password',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(242, 140, 40, 5)),
                      border: UnderlineInputBorder()),
                  style: const TextStyle(fontSize: 25))),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
              width: width * 0.85,
              height: height * 0.08,
              child: IntlPhoneField(
                //pickerDialogStyle: C,
                controller: phoneController,
                onCountryChanged: (phone) =>
                    countryController.text = phone.name,
                initialCountryCode: 'PK',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Color.fromRGBO(242, 140, 40, 5)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              )),
          SizedBox(
              width: width * 0.85,
              height: height * 0.08,
              child: TextField(
                  controller: countryController,
                  readOnly: true,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'country (read only)',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(242, 140, 40, 5))),
                  style: const TextStyle(fontSize: 25))),
          Padding(
              padding:
                  EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
              child: ElevatedButton(
                  onPressed: () => signUpAPI(
                      nameController.text.toString(),
                      emailController.text.toString(),
                      passwordController.text.toString(),
                      countryController.text.toString(),
                      phoneController.text.toString()),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(242, 140, 40, 5)),
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30),
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                'Already have Account?',
                style: TextStyle(color: Colors.white),
              )),
              GestureDetector(
                child: const Text(' Login'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogInScreen())),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
