import 'package:flutter/material.dart';
//import 'signup.dart';
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
              child: Text('Login', style: TextStyle(fontSize: 40)),
            ),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: AutofillHints.email, border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            SizedBox(
              width: width*0.85,
              height: 75,
              child: const TextField(decoration: InputDecoration(hintText: AutofillHints.password, border: UnderlineInputBorder()),style: TextStyle(fontSize: 25))),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage(title: 'Hy'))), 
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow), foregroundColor: MaterialStatePropertyAll(Colors.black), fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)), padding: MaterialStatePropertyAll(EdgeInsets.only(bottom: 10))),
                child: const Text('Login', style: TextStyle(fontSize: 30),),
                )
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Donot have Account?', style: TextStyle(color: Colors.white),)),
                Text(' Sign Up')
              ]
            ),
          ]
        )
    )
    );
  }
}