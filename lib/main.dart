import 'package:flutter/material.dart';

import 'package:lawyer_app/screens/startup.dart' show WelcomePage;

/// * Project - LawyerApp
/// * Author  - Sunera Avinash
void main() {
  return runApp(LawyerApp());
}

/// Create the app and apply theme, title and home
class LawyerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lawyer Database",
      home: WelcomePage(),
    );
  }
}
