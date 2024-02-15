import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Quick Courier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 255, 115, 0),
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color.fromARGB(255, 255, 115, 0),
              displayColor: Color.fromARGB(255, 255, 115, 0)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 255, 115, 0)),
          hintColor: Color.fromARGB(255, 255, 115, 0),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
