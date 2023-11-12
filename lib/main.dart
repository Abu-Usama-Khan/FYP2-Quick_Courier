import 'package:flutter/material.dart';
//import 'login.dart';
//import 'signup.dart';
//import 'explorescreen.dart';
//import 'frontpage.dart';
import 'ListVerificationNote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow,), 
        scaffoldBackgroundColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.yellow,
          displayColor: Colors.yellow
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow
        ),
        hintColor: Colors.yellow,
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page')
      home: const MyWidget()
    );
  }
}