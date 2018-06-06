import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// * Settings Page
/// Contains an App Bar
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsContent(),
    );
  }
}

/// * List to show settings
class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SettingsAbout(),
      ],
    );
  }
}

/// * Show About Box
class SettingsAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationLegalese: "The Billionaire® Developer Team",
      applicationName: "Find Your Lawyer",
      applicationVersion: "Prototype",
      icon: defaultTargetPlatform == TargetPlatform.iOS
          ? Icon(CupertinoIcons.info)
          : Icon(Icons.developer_board),
    );
  }
}
