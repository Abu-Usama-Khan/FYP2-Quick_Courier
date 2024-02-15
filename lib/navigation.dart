import 'package:flutter/material.dart';
import 'package:fyp2/accountLogin.dart';
import 'package:fyp2/accountNotLogin.dart';
import 'package:fyp2/loginFirstAlert.dart';
import 'globalVar.dart';
import 'homeScreen.dart';
import 'AddList.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Scaffold(
      body: SizedBox(
          height: height * 0.88,
          child: PageStorage(bucket: bucket, child: currentScreen)),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 255, 115, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () => token == ''
              ? alertBox(context)
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddListScreen())),
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 255, 115, 0),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScreen = HomeScreen();
                  currentTab = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: currentTab == 0 ? Colors.black : Colors.black54,
                  ),
                  Text('Home',
                      style: TextStyle(
                        color: currentTab == 0 ? Colors.black : Colors.black54,
                      ))
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScreen = token == ''
                      ? AccountNotLoginScreen()
                      : AccountLoginScreen();
                  currentTab = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: currentTab == 1 ? Colors.black : Colors.black54,
                  ),
                  Text('Account',
                      style: TextStyle(
                        color: currentTab == 1 ? Colors.black : Colors.black54,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
