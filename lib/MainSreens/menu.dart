

import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
              title: Text("Categories"),
              centerTitle: true,
              backgroundColor: Colors.blueGrey,
              automaticallyImplyLeading: false),
        ),
        // body:
        // Column(
        //   children: [
        //     Container(
        //       color: Colors.blueGrey,
        //       height: MediaQuery.of(context).size.height / 4,
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(18.0),
        //             child: Text(
        //               "Hey, what would you like to learn today?",
        //               style: TextStyle(fontSize: 20, color: Colors.white),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(10.0),
        //             child: TextField(
        //               decoration: InputDecoration(
        //                   border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(10))),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // )
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  return ListView(
    shrinkWrap: true,
    children: [
      ListTile(
        title: Text("Shopes"),
      ),
      ListTile(
        title: Text("Good words"),
      ),
      ListTile(
        title: Text("Bad words"),
      ),
      ListTile(
        title: Text("Shopes"),
      ),
      ListTile(
        title: Text("Good words"),
      ),
      ListTile(
        title: Text("Bad words"),
      ),
      ListTile(
        title: Text("Shopes"),
      ),
      ListTile(
        title: Text("Good words"),
      ),
      ListTile(
        title: Text("Bad words"),
      )
    ],
  );
}
