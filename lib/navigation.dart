import 'package:flutter/material.dart';
import 'package:fyp2/accountLogin.dart';
import 'package:fyp2/accountNotLogin.dart';
import 'package:fyp2/login.dart';
import 'globalVar.dart';
import 'homeScreen.dart';
import 'AddList.dart';
import 'chat.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> listWidget = [
    ChatScreen(),
    HomeScreen(),
    AddListScreen(),
    AccountLoginScreen(),
  ];

  int bottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: bottomIndex, children: listWidget),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(255, 255, 115, 0),
        ),
        child: BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: bottomIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            //backgroundColor: Colors.yellow,
            onTap: (index) => setState(() {
                  if ((index == 0 || index == 2) && token == '') {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ))),
                                TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogInScreen())),
                                  child: Text('Log in',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                )
                              ],
                              title: Text('Log in',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              content: Text('Please Log in, to continue!',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              buttonPadding: EdgeInsets.only(top: 20),
                              backgroundColor: Color.fromARGB(255, 255, 115, 0),
                            ));
                  } else if (index == 3 && token == '') {
                    listWidget.removeLast();
                    listWidget.add(AccountNotLoginScreen());
                    bottomIndex = index;
                  } else if (index == 3 && token != '') {
                    listWidget.removeLast();
                    listWidget.add(AccountLoginScreen());
                    bottomIndex = index;
                  } else {
                    bottomIndex = index;
                  }
                }),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add List'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account'),
            ]),
      ),
    );
  }
}
