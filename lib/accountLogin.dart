import 'package:flutter/material.dart';
import 'package:fyp2/AddList.dart';
import 'package:fyp2/navigation.dart';
import 'package:fyp2/termsCond.dart';
import 'myList.dart';
import 'profile.dart';
import 'globalVar.dart';

class AccountLoginScreen extends StatefulWidget {
  const AccountLoginScreen({super.key});

  @override
  State<AccountLoginScreen> createState() => _AccountLoginScreenState();
}

class _AccountLoginScreenState extends State<AccountLoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.075, bottom: height * 0.04),
                child: SizedBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/images1.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Your Profile'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('My Lists'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListScreen()))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Add List'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddListScreen()))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Terms & Conditions'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditions()))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text('Delete Account'),
                  trailing: Icon(Icons.arrow_forward),
                  tileColor: Color.fromARGB(255, 255, 115, 0),
                  textColor: Colors.black,
                  iconColor: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Logout'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () {
                      token = '';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
