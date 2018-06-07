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
      body1: TextStyle(
        color: Colors.black,
        fontFamily: "Roboto",
      ),
      body2: TextStyle(
        color: Colors.black,
        fontFamily: "Roboto",
        fontSize: 17.0,
      ),
      button: TextStyle(
        color: Colors.white,
        fontFamily: "RobotoLight",
      ),
      headline: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: "RobotoBlack",
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w500,
        letterSpacing: 1.3,
        color: Colors.black,
        fontSize: 14.0,
        fontFamily: "RobotoMedium",
      ),
      title: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontFamily: "RobotoBlack",
      ),
      caption: TextStyle(
        color: Colors.black,
        fontFamily: "RobotoThin",
      ),
      display1: TextStyle(
        color: Colors.black,
        fontFamily: "RobotoBlack",
      ),
    ),
  );
}
