import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
          child: Text(
            'Explore',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
          color: Colors.transparent,
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color.fromARGB(255, 235, 229, 229),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for a Drop Off Country',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 235, 229, 229)),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 7, right: 7, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2.0),
                          child: Image.network(
                            "data:image/jpeg;base64,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",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 0),
                          child: Text(
                            "Pakistan to Canada",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: 10,
              )),
        ),
      ],
    ));
  }
}
