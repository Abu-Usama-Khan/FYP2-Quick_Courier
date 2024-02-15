import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp2/globalVar.dart';
import 'package:fyp2/successMessage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';

class UpdateMyLocation extends StatefulWidget {
  const UpdateMyLocation({super.key});

  @override
  State<UpdateMyLocation> createState() => _UpdateMyLocationState();
}

class _UpdateMyLocationState extends State<UpdateMyLocation> {
  bool isLoading = false;
  bool isLoading2 = false;
  String curState = '';
  String curCity = '';

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {
      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });

    return await Geolocator.getCurrentPosition();
  }

  void updateLocation(String s, c) async {
    Response response = await put(
        Uri.parse(liveURL + '/api/updateLocationByUser?token=$token'),
        body: {'state': s, 'city': c});
    if (response.statusCode == 200) {
      setState(() {
        isLoading2 = false;
      });
      successMessageFunc(context, 'Location has been Updated Successfully!');
    } else {
      setState(() {
        isLoading2 = false;
      });
      var body = jsonDecode(response.body.toString());
      showErrorMessage(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Update Location')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: width * 0.9,
              height: height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.03,
                    ),
                    child: const Text('Current Location',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  curState != ''
                      ? Padding(
                          padding: EdgeInsets.only(top: height * 0.075),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('State:',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                  Text('City:',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16))
                                ],
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(curState,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                  Text(curCity,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16))
                                ],
                              )
                            ],
                          ))
                      : Text("")
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.6, height * 0.01)),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  getCurrentLocation().then((value) async {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        value.latitude, value.longitude);
                    setState(() {
                      curState = placemarks.reversed.last.administrativeArea
                          .toString();
                    });
                    setState(() {
                      curCity = placemarks.reversed.last.locality.toString();
                    });
                  });
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text('Get Your Current Location')),
            Padding(
              padding: EdgeInsets.only(top: height * 0.25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 0.7, height * 0.01),
                      backgroundColor: curState != ''
                          ? Color.fromARGB(255, 255, 115, 0)
                          : Color.fromARGB(100, 255, 115, 0),
                      foregroundColor:
                          curState != '' ? Colors.black : Colors.black54),
                  onPressed: () {
                    setState(() {
                      isLoading2 = true;
                    });
                    curState != '' ? updateLocation(curState, curCity) : {};
                  },
                  child: isLoading2
                      ? Center(child: CircularProgressIndicator())
                      : const Text(
                          'Update',
                          style: TextStyle(fontSize: 25),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
