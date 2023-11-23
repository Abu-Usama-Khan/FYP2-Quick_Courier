import 'package:flutter/material.dart';
import 'package:fyp2/login.dart';
import 'package:fyp2/signup.dart';

class AccountNotLoginScreen extends StatefulWidget {
  const AccountNotLoginScreen({super.key});

  @override
  State<AccountNotLoginScreen> createState() => _AccountNotLoginScreenState();
}

class _AccountNotLoginScreenState extends State<AccountNotLoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.04),
                child: SizedBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/Quick logo.jpeg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: GestureDetector(
                    child: const Text('Login'),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogInScreen()))),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.04, left: width * 0.05),
                child: Row(
                  children: [
                    const Text(
                      'New on Quick Courier? Click on ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        child: const Text('Sign Up'),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen())))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
