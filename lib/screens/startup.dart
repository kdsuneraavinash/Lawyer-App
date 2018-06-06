import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:lawyer_app/screens/startup/directory.dart'
    show StartupDirectory;
import 'package:lawyer_app/screens/startup/lawnet.dart' show StartupLawnet;
import 'package:lawyer_app/screens/startup/settings.dart' show SettingsPage;

/// Main Welcome Page
/// Consists of Images and a Search box to select District
/// When searched this will direct users to [window_list.LawyerListPage]
class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  int currentPage;
  List<Widget> pages;

  @override
  initState() {
    pages = [
      StartupDirectory(
        themeData: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black45,
        ),
      ),
      StartupLawnet(
        themeData: ThemeData(
          primaryColor: Colors.brown[900],
          accentColor: Colors.amber,
        ),
      ),
      SettingsPage()
    ];
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _handleBottomAppBarTapped,
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.profile_circled)
                : Icon(Icons.contacts),
            backgroundColor: Colors.black,
            title: Text("Directory"),
          ),
          BottomNavigationBarItem(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.search)
                : Icon(Icons.search),
            backgroundColor: Colors.brown[900],
            title: Text("LawNet"),
          ),
          BottomNavigationBarItem(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.info)
                : Icon(Icons.settings_applications),
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }

  void _handleBottomAppBarTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
