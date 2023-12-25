import 'package:flutter/material.dart';
import 'package:fyp2/paymentScreen.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:date_field/date_field.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  TextEditingController destLocController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  var baseCountry = '';
  String? baseCity;
  var destCountry = '';
  String? destCity;
  String? recDate;

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void nullCheck() {
    if (baseCountry != '' &&
        baseCity != '' &&
        destCountry != '' &&
        destCity != '' &&
        recDate != '' &&
        destLocController.text.toString() != '' &&
        descController.text.toString() != '' &&
        priceController.text.toString() != '') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                  baseCtry: baseCountry,
                  baseCty: baseCity,
                  destCtry: destCountry,
                  destCty: destCity,
                  date: recDate,
                  destLoc: destLocController.text.toString(),
                  desc: descController.text.toString(),
                  price: priceController.text.toString())));
    } else {
      showErrorMessage('All fields are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add List'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width * 0.85,
            height: height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: const Text(
                    'Base Region',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: Divider(
                    color: Color.fromARGB(255, 255, 115, 0),
                    thickness: height * 0.003,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: CSCPicker(
                      onCountryChanged: (country) {
                        setState(() {
                          baseCountry = country.toString();
                        });
                      },
                      onStateChanged: (state) {},
                      onCityChanged: (city) {
                        setState(() {
                          baseCity = city;
                        });
                      },
                    )),
                const Text('Destination Region',
                    style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: Divider(
                    color: Color.fromARGB(255, 255, 115, 0),
                    thickness: height * 0.003,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: height * 0.003),
                    child: CSCPicker(
                      onCountryChanged: (country) {
                        setState(() {
                          destCountry = country.toString();
                        });
                      },
                      onStateChanged: (state) {},
                      onCityChanged: (city) {
                        setState(() {
                          destCity = city.toString();
                        });
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02, bottom: height * 0.003),
                    child: DateTimeFormField(
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Recieving Date',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152))),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      firstDate: DateTime.now(),
                      onDateSelected: (value) {
                        recDate = value.month.toString() +
                            '-' +
                            value.day.toString() +
                            '-' +
                            value.year.toString();
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: TextField(
                    controller: destLocController,
                    decoration: const InputDecoration(
                      hintText: 'Destination Address',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Price you pay (in USD dollar)',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: ElevatedButton(
                      onPressed: () => nullCheck(),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 115, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 20, bottom: 20)),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
