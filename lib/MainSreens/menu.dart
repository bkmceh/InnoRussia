import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final categories =
  [
    Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 9, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.home,
              size: 60.0,
            ),
            Text(
              'Basics',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 18, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.shop,
              size: 60.0,
            ),
            Text(
              'Shop',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 9, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.chat,
              size: 60.0,
            ),
            Text(
              'Chatting',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 18, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.star,
              size: 60.0,
            ),
            Text(
              'University',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 9, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.location_city,
              size: 60.0,
            ),
            Text(
              'City',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 18, top: 18,),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.casino,
              size: 60.0,
            ),
            Text(
              'Casino',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 9, top: 18, bottom: 18),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.mood_bad,
              size: 60.0,
            ),
            Text(
              'Bad words',
              style: TextStyle(fontSize: 24),
            ),
          ]),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('Categories',
                style: TextStyle(
                    color: hexToColor('#FFFFFF'),
                    fontSize: 28,
                  ),
                ),
                centerTitle: true,
                backgroundColor: hexToColor("#796CBE"),
                pinned: true,
                expandedHeight: 160,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Hey, what would you like to learn today?',
                          style: TextStyle(
                            color: hexToColor('#FFFFFF'),
                            fontSize: 20,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(6),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                              child: TextField(
                                style: TextStyle(
                                  color: hexToColor('#707070'),
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: hexToColor('#FFFFFF')),
                                    ),
                                    hintText: 'Type to search',
                                    hintStyle: TextStyle(
                                        color: hexToColor('#707070')),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: hexToColor('#FFFFFF'),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                shadowColor: Colors.black,
                elevation: 8.0,
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                children: categories,
              ),
            ],
          ),
        );
  }
}

//
// CustomScrollView(
// slivers: [
// SliverAppBar(
// title: Text("Sample Slivers"),
// backgroundColor: hexToColor("#3D3F70"),
// floating: true,
// pinned: true,
// snap: false,
// actions: [
// GridView.count(
// padding: EdgeInsets.all(10),
// scrollDirection: Axis.vertical,
// crossAxisCount: 2,
// children: categories,
// )
// ],
// ),
// // GridView.count(
// //   padding: EdgeInsets.all(10),
// //   scrollDirection: Axis.vertical,
// //   crossAxisCount: 2,
// //   children: categories,
// // ),
// ],
// ),

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
