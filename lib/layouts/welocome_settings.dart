import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: new SettingsContent(),
    );
  }
  
}

class SettingsContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new AboutListTile(
      applicationLegalese: "The Billionaire(R) Developer Team",
      applicationName: "Find Your Lawyer",
      applicationVersion: "Prototype",
      child: new Text("About this App"),
      icon: new Icon(Icons.developer_board),
    );
  }

}