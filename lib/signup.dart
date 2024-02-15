import 'package:flutter/material.dart';
import 'package:fyp2/termsCond.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:csc_picker/csc_picker.dart';
import 'navigation.dart';
import 'login.dart';
import 'globalVar.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfrmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void showErrorMessage(message) {
    SnackBar snackBarMessage = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[200],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
  }

  void signUpAPI(String name, email, password, phone, state, city) async {
    Response response =
        await post(Uri.parse(liveURL + 'api/userSignUp'), body: {
      'emailAddress': email,
      'phoneNumber': phone,
      'fullName': name,
      'password': password,
      'country': 'Pakistan',
      'state': state,
      'city': city
    });
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      token = body['token'];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(body['message']);
    }
  }

  bool isVisible = true;
  bool isVisible2 = true;
  bool? checkValue = false;
  bool isLoading = false;
  String validate = '';
  String? stateValue;
  String? cityValue;
  String? countryValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SizedBox(
            width: 500,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: const Text('Sign Up!', style: TextStyle(fontSize: 40)),
              ),
              SizedBox(
                  width: width * 0.85,
                  height: height * 0.09,
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: AutofillHints.name,
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(242, 140, 40, 5),
                            fontSize: 20),
                        border: UnderlineInputBorder(),
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 25))),
              SizedBox(
                  width: width * 0.85,
                  height: height * 0.09,
                  child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val != null) {
                          validate = val;
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return null;
                          } else {
                            return 'Enter a valid email address';
                          }
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: AutofillHints.email,
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(242, 140, 40, 5),
                            fontSize: 20),
                        border: UnderlineInputBorder(),
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 25))),
              SizedBox(
                  width: width * 0.85,
                  height: height * 0.09,
                  child: TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val != null) {
                        if (val.length < 6) {
                          return 'Password should atleast 6 characters long';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                    obscureText: isVisible,
                    decoration: InputDecoration(
                        labelText: AutofillHints.password,
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(242, 140, 40, 5),
                            fontSize: 20),
                        border: UnderlineInputBorder(),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: Color.fromARGB(255, 255, 115, 0),
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        )),
                    style: const TextStyle(fontSize: 25),
                  )),
              SizedBox(
                  width: width * 0.85,
                  height: height * 0.09,
                  child: TextFormField(
                      controller: cnfrmPasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) =>
                          val == passwordController.text.toString()
                              ? null
                              : 'Password does not match',
                      obscureText: isVisible2,
                      decoration: InputDecoration(
                          labelText: 'Confirmed Password',
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(242, 140, 40, 5),
                              fontSize: 20),
                          border: UnderlineInputBorder(),
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 255, 115, 0),
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible2 = !isVisible2;
                              });
                            },
                          )),
                      style: const TextStyle(fontSize: 25))),
              SizedBox(
                height: height * 0.02,
              ),
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
                          color: Color.fromRGBO(242, 140, 40, 5), fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.85,
                height: height * 0.12,
                child: CSCPicker(
                  defaultCountry: CscCountry.Pakistan,
                  disableCountry: true,
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: checkValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkValue = newValue;
                            });
                          },
                        ),
                        const Text(
                          'I agree to the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          child: const Text('QC Terms and Conditions'),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions())),
                        )
                      ])),
              Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.03, bottom: height * 0.02),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (cnfrmPasswordController.text.toString() ==
                            passwordController.text.toString()) {
                          if (checkValue == true) {
                            if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(validate)) {
                              if (passwordController.text.toString().length >
                                  5) {
                                if (stateValue != null && cityValue != null) {
                                  signUpAPI(
                                      nameController.text.toString(),
                                      emailController.text.toString(),
                                      passwordController.text.toString(),
                                      phoneController.text.toString(),
                                      stateValue,
                                      cityValue);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showErrorMessage('Enter your State and City');
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                showErrorMessage(
                                    'Password should atleast 6 characters long');
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              showErrorMessage('Enter a valid email address');
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            showErrorMessage(
                                'Accept the terms and conditions first!');
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          showErrorMessage('Password does not match');
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 115, 0)),
                        foregroundColor: MaterialStatePropertyAll(Colors.black),
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(200)),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 30),
                            ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                      child: Text(
                    'Already have Account?',
                    style: TextStyle(color: Colors.black),
                  )),
                  GestureDetector(
                      child: const Text(' Login'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInScreen()));
                      })
                ],
              )
            ]),
          ),
        ));
  }
}
