import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Quick Courier'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 70, 0, 5),
            child: Image(image: AssetImage('assets/images/Quick logo.jpeg')),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    padding: EdgeInsets.all(20)),
                child: Text("Let's Go")),
          ),
        ]));
  }
}
