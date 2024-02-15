import 'package:flutter/material.dart';
import 'package:fyp2/AddList.dart';
import 'package:fyp2/accountLogoutDelete.dart';
import 'package:fyp2/reportIssues.dart';
import 'package:fyp2/termsCond.dart';
import 'package:fyp2/trackParcel.dart';
import 'package:fyp2/updateLocation.dart';
import 'myList.dart';
import 'profile.dart';

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
        width: width * 0.9,
        child: SingleChildScrollView(
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
                padding: EdgeInsets.only(bottom: height * 0.02),
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
                padding: EdgeInsets.only(bottom: height * 0.02),
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
                padding: EdgeInsets.only(bottom: height * 0.02),
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
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Update your Location'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateMyLocation()))),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Track Parcel'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackParcel()))),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Report an Issue'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => repIssue()))),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
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
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Logout'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Color.fromARGB(255, 255, 115, 0),
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    onTap: () {
                      confirmLogoutDelete(
                          context, 'Logout', 'Are you sure?', 'l');
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Delete Account'),
                    trailing: Icon(Icons.arrow_forward),
                    tileColor: Colors.black,
                    textColor: Color.fromARGB(255, 255, 115, 0),
                    iconColor: Color.fromARGB(255, 255, 115, 0),
                    onTap: () {
                      confirmLogoutDelete(
                          context, 'Delete Account', 'Are you sure?', 'd');
                    }),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
