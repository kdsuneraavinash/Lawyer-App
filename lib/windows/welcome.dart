import 'package:flutter/material.dart';

import 'package:lawyer_app/layouts/welcome_directory.dart' as directory;
import 'package:lawyer_app/layouts/welcome_lawnet.dart' as lawnet;

/// Main Welcome Page
/// Consists of Images and a Search box to select District
/// When searched this will direct users to [window_list.LawyerListPage]
class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage;
  List<Widget> pages;

  @override
  initState() {
    pages = [
      new directory.WelcomeDirectory(),
      new lawnet.WelcomeLawnet(),
      new Container(color: Colors.black,)
    ];
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _handleBottomAppBarTapped,
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: const Icon(Icons.contacts),
            backgroundColor: Colors.black,
            title: new Text("Directory"),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            backgroundColor: Colors.brown[900],
            title: new Text("LawNet"),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.developer_board),
            backgroundColor: Colors.black,
            title: new Text("About"),
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
