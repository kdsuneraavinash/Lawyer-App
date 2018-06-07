import 'package:flutter/material.dart';

final ThemeData kAndroidTheme = _buildAndroidTheme();

ThemeData _buildAndroidTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    accentColor: Colors.grey,
    backgroundColor: Colors.grey[200],
    bottomAppBarColor: Colors.black,
    disabledColor: Colors.grey[400],
    buttonColor: Colors.black,
    dividerColor: Colors.black,
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.white),
      headline: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w500,
        letterSpacing: 1.3,
        color: Colors.black,
        fontSize: 13.0
      ),
      title: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600
      ),
      caption: TextStyle(
        color: Colors.black
      )
    ),
    
  );
}
