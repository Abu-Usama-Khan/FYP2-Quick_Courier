import 'package:flutter/material.dart';
import 'package:fyp2/paymentScreen.dart';
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

  String? recDate;
  String? chooseValueFrom;
  String? chooseValueTo;
  int value = 1;
  List itemList = [
    'Hyderabad',
    'Islamabad',
    'Karachi',
    'Lahore',
    'Multan',
    'Peshawar',
    'Queta'
  ];

  void showErrorMessage(msg) {
    SnackBar snckbar =
        SnackBar(content: Text(msg), backgroundColor: Colors.red[200]);
    ScaffoldMessenger.of(context).showSnackBar(snckbar);
  }

  void nullCheck() {
    if (chooseValueFrom != null &&
        chooseValueTo != null &&
        recDate != '' &&
        destLocController.text.toString() != '' &&
        descController.text.toString() != '' &&
        priceController.text.toString() != '') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                  fromCity: chooseValueFrom,
                  toCity: chooseValueTo,
                  date: recDate,
                  destLoc: destLocController.text.toString(),
                  desc: descController.text.toString(),
                  price: priceController.text.toString(),
                  weight: value.toString())));
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
                    'From City',
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
                  child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Select City'),
                      items: itemList.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                      value: chooseValueFrom,
                      onChanged: (newValue) {
                        setState(() {
                          chooseValueFrom = newValue.toString();
                        });
                      },
                      iconSize: width * 0.08,
                      iconEnabledColor: Color.fromARGB(255, 255, 115, 0)),
                ),
                const Text('To City', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: Divider(
                    color: Color.fromARGB(255, 255, 115, 0),
                    thickness: height * 0.003,
                  ),
                ),
                DropdownButton(
                    isExpanded: true,
                    hint: Text('Select City'),
                    items: itemList.map((valueItem) {
                      return DropdownMenuItem(
                          value: valueItem, child: Text(valueItem));
                    }).toList(),
                    value: chooseValueTo,
                    onChanged: (newValue) {
                      setState(() {
                        chooseValueTo = newValue.toString();
                      });
                    },
                    iconSize: width * 0.08,
                    iconEnabledColor: Color.fromARGB(255, 255, 115, 0)),
                Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03, bottom: height * 0.003),
                    child: DateTimeFormField(
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          suffixIconColor: Color.fromARGB(255, 255, 115, 0),
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
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Destination Address',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 17),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    style: TextStyle(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 17),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.003),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Price you pay (in PKR)',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 152, 152, 152),
                          fontSize: 17),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Approx Weight (in KGs):',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 115, 0))),
                      Container(
                        width: width * 0.25,
                        color: Color.fromARGB(150, 255, 115, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Color.fromARGB(255, 255, 115, 0),
                              child: InkWell(
                                  onTap: () {
                                    if (value > 1) {
                                      setState(() {
                                        value = value - 1;
                                      });
                                    }
                                  },
                                  child:
                                      Icon(Icons.remove, size: width * 0.075)),
                            ),
                            Text(value.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Container(
                              color: Color.fromARGB(255, 255, 115, 0),
                              child: InkWell(
                                  onTap: () {
                                    if (value < 20) {
                                      setState(() {
                                        value = value + 1;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.add, size: width * 0.075)),
                            ),
                          ],
                        ),
                      )
                    ],
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
