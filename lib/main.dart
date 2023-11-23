import 'package:flutter/material.dart';
//import 'login.dart';
import 'navigation.dart';
//import 'frontpage.dart';
//import 'ListVerificationNote.dart';

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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(242, 140, 40, 5),
          ),
          scaffoldBackgroundColor: Colors.black,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color.fromRGBO(242, 140, 40, 5),
              displayColor: Color.fromRGBO(242, 140, 40, 5)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(242, 140, 40, 5)),
          hintColor: Color.fromRGBO(242, 140, 40, 70),
          useMaterial3: true,
        ),
        //home: const LogInScreen()
        home: const MyHomePage()
        //home: const MyWidget()
        );
  }
}
