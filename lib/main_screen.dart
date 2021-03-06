import 'package:flutter/material.dart';

import 'MainSreens/menu.dart';
import 'MainSreens/settings.dart';
import 'MainSreens/vocabulary.dart';


class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final tabsScreens = [
    Menu(),
    Vocabulary(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabsScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text("Menu"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: Text("Vocabulary"),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;

          });
        },
      ),
    );
  }
}

