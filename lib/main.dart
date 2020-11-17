import 'package:flutter/material.dart';
import 'package:inno_russian/main_screen.dart';
// import 'package:inno_russian/verification.dart';
//
// import 'sign_in.dart';

void main() {
  runApp(
    new MaterialApp(
      home: MainNavigation(),
      routes: {
        "/verification": (context) => Verification(),
        "/mainNavigation": (context) => MainNavigation()
      },
    )
  );
}



