import 'package:flutter/material.dart';
import 'package:inno_russian/MainSreens/categories.dart';
import 'package:inno_russian/MainSreens/dictionaries.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inno_russian/MainSreens/words.dart';

String access_token =
    'access_token="JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2MjE0NTA1MzUsImlhdCI6MTYwNTg5ODIzNX0.ebCpbKouFtKidcQs-Cwxm9eP8aUEcSthFUjJ6nWKd3Q"';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const String dictionaryUrl =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/dictionaries/';

  List<Dictionaries> dictionaries = List();

  @override
  void initState() {
    parseDictionariesList().then((value) => {
          setState(() {
            dictionaries = value;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dictionaries.isEmpty
          ? Center(
              child: Container(
              child: CircularProgressIndicator(
                backgroundColor: hexToColor("#796CBE"),
                strokeWidth: 7,
              ),
            ))
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text(
                    'Dictionaries',
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
                                      borderSide: BorderSide(
                                          color: hexToColor('#FFFFFF')),
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
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Subcategories(dictionaries[index].name,
                                  dictionaries[index].id);
                            }));
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SvgPicture.network(
                                    'https://intense-meadow-04093.herokuapp.com${dictionaries[index].file}',
                                    semanticsLabel: 'A shark?!',
                                    placeholderBuilder:
                                        (BuildContext context) => Container(
                                            padding: const EdgeInsets.all(30.0),
                                            child:
                                                const CircularProgressIndicator()),
                                    fit: BoxFit.contain,
                                  ),
                                  height: 80,
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    dictionaries[index].name,
                                    style: TextStyle(fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }, childCount: dictionaries.length),
                ),
              ],
            ),
    );
  }

  Future<List<Dictionaries>> parseDictionariesList() async {
    final data =
        await http.get(dictionaryUrl, headers: {'Cookie': access_token});
    print(data.body);
    List<dynamic> decodeJson = jsonDecode(data.body);
    DictionariesList categoriesList =
        DictionariesList.fromMappedJson(decodeJson);
    return categoriesList.dictionaries;
  }
}

class Subcategories extends StatefulWidget {
  final name;
  final id;

  Subcategories(this.name, this.id);

  @override
  _SubcategoriesState createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  String categoryUrl =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/categories/';

  Categories categories;

  @override
  void initState() {
    parseCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: categories == null
          ? Center(
              child: Container(
              child: CircularProgressIndicator(
                backgroundColor: hexToColor("#796CBE"),
                strokeWidth: 7,
              ),
            ))
          : CustomScrollView(
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
                                      borderSide: BorderSide(
                                          color: hexToColor('#FFFFFF')),
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
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return WordsOfCategory(
                                  categories.categoriesList[index]['name'],
                                  categories.categoriesList[index]['id']);
                            }));
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SvgPicture.network(
                                    'https://intense-meadow-04093.herokuapp.com${categories.categoriesList[index]['file']}',
                                    semanticsLabel: 'A shark?!',
                                    placeholderBuilder:
                                        (BuildContext context) => Container(
                                            padding: const EdgeInsets.all(30.0),
                                            child:
                                                const CircularProgressIndicator()),
                                    fit: BoxFit.contain,
                                  ),
                                  height: 80,
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      categories.categoriesList[index]['name'],
                                      style: TextStyle(fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }, childCount: categories.categoriesList.length),
                ),
              ],
            ),
    );
  }

  Future<Categories> parseCategories() async {
    final data = await http
        .get(categoryUrl + '${widget.id}/', headers: {'Cookie': access_token});
    print(data.body);
    Map<String, dynamic> decodeJson = jsonDecode(data.body);
    print(decodeJson['categories']);
    Categories categories = Categories.fromMappedJson(decodeJson);
    return categories;
  }
}

class WordsOfCategory extends StatefulWidget {
  final name;
  final id;

  WordsOfCategory(this.name, this.id);

  @override
  _WordsOfCategoryState createState() => _WordsOfCategoryState();
}

class _WordsOfCategoryState extends State<WordsOfCategory> {
  String wordUrl =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/words/';

  Words words;

  @override
  void initState() {
    parseWords().then((value) {
      setState(() {
        words = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: words == null
          ? Center(
              child: Container(
              child: CircularProgressIndicator(
                backgroundColor: hexToColor("#796CBE"),
                strokeWidth: 7,
              ),
            ))
          : CustomScrollView(
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
                                      borderSide: BorderSide(
                                          color: hexToColor('#FFFFFF')),
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: hexToColor("#796CBE"),
                        height: MediaQuery.of(context).size.height / 5,
                        child: Text(
                          '${words.wordsList[index]['description']}',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      );
                    },
                    childCount: words.wordsList.length,
                  ),
                ),
              ],
            ),
    );
  }

  Future<Words> parseWords() async {
    final data = await http
        .get(wordUrl + '${widget.id}/', headers: {'Cookie': access_token});
    print(data.body);
    Map<String, dynamic> decodeJson = jsonDecode(data.body);
    print(decodeJson['words']);
    Words words = Words.fromMappedJson(decodeJson);
    return words;
  }
}
