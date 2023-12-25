import 'package:flutter/material.dart';
import 'globalVar.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future getUserProfile() async {
    Response response =
        await get(Uri.parse(liveURL + 'api/getUserProfile?token=$token'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
            child: SizedBox(
          width: 500,
          child: Column(children: [
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
            Expanded(
                child: FutureBuilder(
                    future: getUserProfile(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        return Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.02,
                                left: width * 0.05,
                                right: width * 0.05),
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(snapshot.data!['fullName']),
                                tileColor: Color.fromARGB(255, 255, 115, 0),
                                textColor: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.02,
                                left: width * 0.05,
                                right: width * 0.05),
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(snapshot.data!['emailAddress']),
                                tileColor: Color.fromARGB(255, 255, 115, 0),
                                textColor: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.02,
                                left: width * 0.05,
                                right: width * 0.05),
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(snapshot.data!['phoneNumber']),
                                tileColor: Color.fromARGB(255, 255, 115, 0),
                                textColor: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.02,
                                left: width * 0.05,
                                right: width * 0.05),
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(snapshot.data!['country']),
                                tileColor: Color.fromARGB(255, 255, 115, 0),
                                textColor: Colors.black),
                          ),
                        ]);
                      }
                    })),
          ]),
        )));
  }
}
