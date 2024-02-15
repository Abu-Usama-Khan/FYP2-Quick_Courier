import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp2/detailedScreen.dart';
import 'package:fyp2/detailedScreen2.dart';
import 'package:fyp2/globalVar.dart';
import 'package:http/http.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with TickerProviderStateMixin {
  Future getActiveList() async {
    Response response = await get(
        Uri.parse(liveURL + 'api/fetchAllActiveListByUser?token=' + token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'].toList();
    } else {
      return [];
    }
  }

  Future getPendingList() async {
    Response response =
        await get(Uri.parse(liveURL + 'api/fetchPendingList?token=' + token));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'].toList();
    } else {
      return [];
    }
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }

  static const List<Tab> _tabs = [
    const Tab(text: 'Active List'),
    const Tab(text: 'Pending List')
  ];

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: _tabs,
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: height * 0.03,
            bottom: height * 0.03,
          ),
          width: width * 0.9,
          height: height * 0.9,
          child: TabBarView(controller: _tabController, children: [
            FutureBuilder(
                future: getActiveList(),
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
                        return snapshot.data.length == 0
                            ? Center(child: Text('Nothing to show'))
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailedScreen2(
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
                }),
            FutureBuilder(
                future: getPendingList(),
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
                        print(snapshot.data.length);
                        return snapshot.data.length == 0
                            ? Center(
                                child: Text('Nothing to show',
                                    style: TextStyle(color: Colors.black)))
                            : Padding(
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
                })
          ]),
        ),
      ),
    );
  }
}
