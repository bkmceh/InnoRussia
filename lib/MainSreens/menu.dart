import 'package:flutter/material.dart';
import 'package:inno_russian/MainSreens/categories.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animations/loading_animations.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List name = List();
  List<Categories> categories = List();

  @override
  void initState() {
    parseCategoriesList().then((value) => {
          setState(() {
            categories = value;
          })
        });
    // print(categories);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Categories',
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
                    Text(
                      'Hey, what would you like to learn today?',
                      style: TextStyle(
                        color: hexToColor('#FFFFFF'),
                        fontSize: 20,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(6),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 13, top: 10),
                          child: TextField(
                            style: TextStyle(
                              color: hexToColor('#707070'),
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: hexToColor('#FFFFFF')),
                              ),
                              hintText: 'Type to search',
                              hintStyle:
                                  TextStyle(color: hexToColor('#707070')),
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: hexToColor('#FFFFFF'),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            shadowColor: Colors.black,
            elevation: 8.0,
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: (index % 2 == 0) ? 18.0 : 9,
                  right: (index % 2 == 0) ? 9 : 18,
                  top: 18,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  shadowColor: Colors.black,
                  elevation: 5.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Subcategory(categories[index].name);
                      }));
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: SvgPicture.network(
                              'https://intense-meadow-04093.herokuapp.com${categories[index].file}',
                              semanticsLabel: 'A shark?!',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CircularProgressIndicator()),
                              fit: BoxFit.contain,
                            ),
                            height: 80,
                            width: 80,
                          ),
                          // Image.network('https://intense-meadow-04093.herokuapp.com${categories[index].file}'),
                          Text(
                            categories[index].name,
                            style: TextStyle(fontSize: 24),
                          ),
                        ]),
                  ),
                ),
              );
            }, childCount: categories.length),
          ),
        ],
      ),
    );
  }

  Future<List<Categories>> parseCategoriesList() async {
    final data = await http.get(
        'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/dictionaries/',
        headers: {
          'Cookie':
              'access_token="JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1LCJleHAiOjE2MjExNTg5NDQsImlhdCI6MTYwNTYwNjY0NH0.t6CW7YTVs0paiArUAopMbAlW5_4sysVZhxpiQqxeF0k"'
        });
    print(data.body);
    List<dynamic> decodeJson = jsonDecode(data.body);
    // print(decodeJson);
    CategoriesList categoriesList = CategoriesList.fromMappedJson(decodeJson);
    return categoriesList.categories;
  }
}

class Subcategory extends StatefulWidget {
  final name;

  Subcategory(this.name);

  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.name,
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
                    Text(
                      'Hey, what would you like to learn today?',
                      style: TextStyle(
                        color: hexToColor('#FFFFFF'),
                        fontSize: 20,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(6),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 13, top: 10),
                          child: TextField(
                            style: TextStyle(
                              color: hexToColor('#707070'),
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: hexToColor('#FFFFFF')),
                              ),
                              hintText: 'Type to search',
                              hintStyle:
                                  TextStyle(color: hexToColor('#707070')),
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: hexToColor('#FFFFFF'),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            shadowColor: Colors.black,
            elevation: 8.0,
          ),
        ],
      ),
    );
  }
}
