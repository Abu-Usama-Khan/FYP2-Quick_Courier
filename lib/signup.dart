import 'package:flutter/material.dart';
//import 'login.dart';
//import 'globalVar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    //var height = size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text('Sign Up!', style: TextStyle(fontSize: 40)),
            ),
            SizedBox(
              width:width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: 'Full Name', border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: 'Email Address', border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: 'Password', border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: 'Country', border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: 'Phone Number', border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage(title: 'Hy'))), 
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow), foregroundColor: MaterialStatePropertyAll(Colors.black), fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)), padding: MaterialStatePropertyAll(EdgeInsets.only(bottom: 10))),
                child: const Text('Sign Up', style: TextStyle(fontSize: 30),)
                )
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Already have Account?', style: TextStyle(color: Colors.white),)),
                Text(' Login')
              ],
            )
          ]
        ),
      )
    );
  }
}