import 'package:flutter/material.dart';
import 'package:fyp2/payment%20screen.dart';
import 'package:fyp2/globalVar.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  TextEditingController baseCountryController = TextEditingController();
  TextEditingController baseCityController = TextEditingController();
  TextEditingController destCountryController =
      TextEditingController(text: userCountry);
  TextEditingController destCityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController destLocController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void nullCheck() {
    if (baseCountryController.text.toString() == '' &&
        baseCityController.text.toString() == '' &&
        destCityController.text.toString() == '' &&
        dateController.text.toString() == '' &&
        destLocController.text.toString() == '' &&
        descController.text.toString() == '' &&
        priceController.text.toString() == '') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                  baseCtry: baseCountryController.text.toString(),
                  baseCity: baseCityController.text.toString(),
                  destCity: destCityController.text.toString(),
                  date: dateController.text.toString(),
                  destLoc: destLocController.text.toString(),
                  desc: descController.text.toString(),
                  price: priceController.text.toString())));
    } else {
      showErrorMessage('All fields are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add List'),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: baseCountryController,
                  decoration: InputDecoration(hintText: "Base Country"),
                ),
                TextField(
                    controller: baseCityController,
                    decoration: InputDecoration(hintText: "Base City")),
                TextField(
                  controller: destCountryController,
                  readOnly: true,
                ),
                TextField(
                    controller: destCityController,
                    decoration: InputDecoration(hintText: "Destination City")),
                TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        hintText: "Recieving Date",
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.date_range)))),
                TextField(
                    controller: destLocController,
                    decoration:
                        InputDecoration(hintText: "Destination Address")),
                TextField(
                    controller: descController,
                    decoration: InputDecoration(hintText: "Description")),
                TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                        hintText: "Price you pay (in USD dollar)",
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.payments)))),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () => nullCheck(),
                    child: Icon(Icons.post_add),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Color.fromRGBO(242, 140, 40, 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
