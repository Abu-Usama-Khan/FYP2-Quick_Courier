import "package:flutter/material.dart";

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Courier'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Note",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  "Your list will first be verified by the Admin and if it follows our rules & regulations , the process will further proceed.",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}