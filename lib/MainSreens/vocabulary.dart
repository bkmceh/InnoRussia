import 'package:flutter/material.dart';

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Your Vocabulary",
        style: TextStyle(fontSize: 35),
      )),
    );
  }
}
