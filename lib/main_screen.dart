import 'package:flutter/material.dart';
import 'package:inno_russian/MainSreens/settings.dart';
import 'package:inno_russian/MainSreens/vocabulary.dart';
import 'package:inno_russian/navigation.dart';

import 'MainSreens/menu.dart';



class MainNavigation extends StatefulWidget {
  final String access_token;

  MainNavigation(this.access_token);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;




  @override
  void initState() {
    NavigationButton.token = widget.access_token;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationButton.tabsScreens[_currentIndex],
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
