import 'package:flutter/material.dart';
import 'package:inno_russian/MainSreens/categories.dart';
import 'package:inno_russian/MainSreens/dictionaries.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inno_russian/MainSreens/words.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:inno_russian/sign_in.dart';

// String access_token =
//     'access_token="JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2MjE0NTA1MzUsImlhdCI6MTYwNTg5ODIzNX0.ebCpbKouFtKidcQs-Cwxm9eP8aUEcSthFUjJ6nWKd3Q"';
String firstUrl = 'access_token="JWT ';

class Menu extends StatefulWidget {
  final String access_token;

  Menu(this.access_token);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const String dictionaryUrl =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/dictionaries/';

  List<Dictionaries> dictionaries = List();

  @override
  void initState() {
    print("WORKING CHECKING TOKEN ${widget.access_token}");
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
                                  dictionaries[index].id, widget.access_token);
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
    print('$firstUrl + ${widget.access_token}"');
    final data =
        await http.get(dictionaryUrl, headers: {'Cookie': '${firstUrl + widget.access_token}"'});
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
  final access_token;

  Subcategories(this.name, this.id, this.access_token);

  @override
  _SubcategoriesState createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  String categoryUrl =
      'https://intense-meadow-04093.herokuapp.com/api/v1.0/data/categories/';

  Categories categories;

  @override
  void initState() {
    print("WORKING CHECKING TOKEN 2 ${widget.access_token}");
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
                                  categories.categoriesList[index]['id'],
                                  widget.access_token);
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
    final data = await http.get(categoryUrl + '${widget.id}/',
        headers: {'Cookie': '${firstUrl + widget.access_token}"'});
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
  final access_token;

  WordsOfCategory(this.name, this.id, this.access_token);

  @override
  _WordsOfCategoryState createState() => _WordsOfCategoryState();
}

class _WordsOfCategoryState extends State<WordsOfCategory> {
  AudioPlayer audioPlayer = new AudioPlayer();

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
                        height: MediaQuery.of(context).size.height * 0.17,
                        color: hexToColor("#FFFFFF"),
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: hexToColor("#796CBE"),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          alignment: Alignment.topCenter,
                          //color: hexToColor("#796CBE"),
                          width: MediaQuery.of(context).size.width * 0.95,
                          height:
                              MediaQuery.of(context).size.height * 0.17 - 15,
                          //padding: EdgeInsets.only(top: 40),
                          child: Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.95 *
                                      0.85,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${words.wordsList[index]['description']}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                      textAlign: TextAlign.left,
                                    ),
                                  )),
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: MediaQuery.of(context).size.width *
                                    0.95 *
                                    0.15,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.bookmark),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.volume_up),
                                      onPressed: () => playLocal(index),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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
    final data = await http.get(wordUrl + '${widget.id}/',
        headers: {'Cookie': '${firstUrl + widget.access_token}"'});
    print(data.body);
    Map<String, dynamic> decodeJson = jsonDecode(data.body);
    print(decodeJson['words']);
    Words words = Words.fromMappedJson(decodeJson);
    return words;
  }

  playLocal(int index) async {
    var url = "https://intense-meadow-04093.herokuapp.com" +
        words.wordsList[index]['file'];

    int result = await audioPlayer.play(url, isLocal: false);
    if (result == 1) {
      // success
    }
    //int result = await audioPlayer.play(, isLocal: true);
  }
}
