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
    pages = [StartupDirectory(), StartupLawnet(), SettingsPage()];
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleBottomAppBarTapped,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: defaultTargetPlatform == TargetPlatform.iOS
                  ? Icon(CupertinoIcons.profile_circled)
                  : Icon(Icons.contacts),
              title: Text("Directory"),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: defaultTargetPlatform == TargetPlatform.iOS
                ? Icon(CupertinoIcons.search)
                : Icon(Icons.search),
            title: Text("LawNet"),
            backgroundColor: Colors.brown[800],
          ),
          BottomNavigationBarItem(
              icon: defaultTargetPlatform == TargetPlatform.iOS
                  ? Icon(CupertinoIcons.info)
                  : Icon(Icons.settings_applications),
              title: Text("Settings"),
              backgroundColor: Colors.black),
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
