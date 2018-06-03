import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:lawyer_app/windows/welcome.dart';

/// * Project - LawyerApp
/// * Author  - Sunera Avinash
void main() {
  return runApp(new LawyerApp());
}

ThemeData _kAndroidTheme = new ThemeData(
  accentColor: Colors.black12,
  primaryColor: Colors.black,
);

ThemeData _kiOSTheme = new ThemeData(
  accentColor: Colors.black12,
  primaryColor: Colors.black,
);

/// Create the app and apply theme, title and home
class LawyerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Lawyer Database",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? _kiOSTheme
          : _kAndroidTheme,
      home: new WelcomePage(),
    );
  }
}
