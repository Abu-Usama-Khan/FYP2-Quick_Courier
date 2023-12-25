import 'dart:async';
import 'package:flutter/material.dart';
import 'navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: AssetImage('assets/images/Quick logo.jpeg')),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      backgroundColor: Color.fromARGB(255, 255, 115, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      padding: EdgeInsets.all(20)),
                  child: Text(
                    "Let's Go",
                    style: TextStyle(fontSize: 30),
                  )),
            ),
          ]),
        ));
  }
}
