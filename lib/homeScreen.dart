import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp2/detailedScreen.dart';
import 'package:fyp2/globalVar.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getList() async {
    Response response =
        await get(Uri.parse(liveURL + 'api/fetchAllActiveList'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'].toList();
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
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: height * 0.06,
            bottom: height * 0.03,
          ),
          width: width * 0.9,
          height: height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 10.0, right: 10.0),
                child: const Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 10.0, bottom: 10, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 255, 115, 0),
                    ),
                    const SizedBox(width: 8.0),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for a Drop Off Country',
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 255, 115, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: getList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                                width: width * 0.1,
                                height: width * 0.1,
                                child: const CircularProgressIndicator()),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailedScreen(
                                              dataMap: snapshot.data[index]))),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/images/download2.jpg'),
                                            )),
                                        ListTile(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12)),
                                            ),
                                            tileColor: Color.fromARGB(
                                                255, 255, 115, 0),
                                            title: Text(snapshot.data[index]
                                                        ['baseCity']
                                                    .toString() +
                                                ' to ' +
                                                snapshot.data[index]
                                                        ['destinationCity']
                                                    .toString()),
                                            trailing: Text(snapshot.data[index]
                                                        ['price']
                                                    .toString() +
                                                ' PKR'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
