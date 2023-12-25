import 'dart:convert';
import 'package:flutter/material.dart';
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
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder(
            future: getActiveList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                              tileColor: Color.fromARGB(255, 255, 115, 0),
                              title: Text(snapshot.data[index]['baseCountry']
                                      .toString() +
                                  ' to ' +
                                  snapshot.data[index]['destinationCountry']
                                      .toString()),
                              subtitle: Text(
                                  snapshot.data[index]['baseCity'].toString() +
                                      ' to ' +
                                      snapshot.data[index]['destinationCity']
                                          .toString()),
                              trailing: Text(
                                  snapshot.data[index]['price'].toString())));
                    });
              }
            }),
        FutureBuilder(
            future: getPendingList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                              tileColor: Color.fromARGB(255, 255, 115, 0),
                              title: Text(snapshot.data[index]['baseCountry']
                                      .toString() +
                                  ' to ' +
                                  snapshot.data[index]['destinationCountry']
                                      .toString()),
                              subtitle: Text(
                                  snapshot.data[index]['baseCity'].toString() +
                                      ' to ' +
                                      snapshot.data[index]['destinationCity']
                                          .toString()),
                              trailing: Text(
                                  snapshot.data[index]['price'].toString())));
                    });
              }
            })
      ]),
    );
  }
}
