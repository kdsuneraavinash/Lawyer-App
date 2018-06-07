import 'package:flutter/material.dart';

import 'package:lawyer_app/screens/directory_list.dart' show LawyerListPage;

import 'package:lawyer_app/values/districts.dart' show districts;

import 'package:lawyer_app/dialogs/radio.dart' show RadioDialog;

import 'package:lawyer_app/widgets/rounded_button.dart' show RoundedButton;
import 'package:lawyer_app/widgets/container_card.dart' show ContainerCard;

/// * All content of [WelcomePage] directory part
/// Contains
/// > Header - Image
/// > Center - Area with background image with search box
class StartupDirectory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartupDirectoryState();
}

class StartupDirectoryState extends State<StartupDirectory> {
  int _selectedDistrict = 0;

  /// * Main page with background Image
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // TODO: Add a more beautiful Image
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: _buildCenterContainer(context),
    );
  }

  /// * Central Container
  /// Consist of SearchBox and SearchButton
  Widget _buildCenterContainer(BuildContext context) {
    return ContainerCard(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCardTitle(context),
            Divider(),
            _buildSearchLabel(context),
            _buildDistrictField(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RoundedButton(
                  text: "Pinned",
                  // TODO: Add Pinned Lawyers Page
                  onPressed: () => null,
                ),
                Tooltip(
                  message:
                      "Show all Lawyers in ${districts[this._selectedDistrict]}",
                  child: RoundedButton(
                    text: "Show Lawyers",
                    onPressed: _handleSearchPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// * Card Title
  /// Title of Container
  Widget _buildCardTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Lawyers' Directory",
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  /// * Search Label Layout
  /// Just a Label
  Widget _buildSearchLabel(BuildContext context) {
    return Container(
      child: Text(
        "Select District",
        style: Theme.of(context).textTheme.subhead,
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
    );
  }

  /// * Select District Button
  /// Will show district chosen by user
  /// And also trigger a dialog box to choose a district
  /// when pressed shows a dialog to chose district
  Widget _buildDistrictField(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Tooltip(
        message: "Set the District to Search",
        child: RaisedButton(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(districts[_selectedDistrict]),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
          onPressed: () => _handleSelectDistrict(context),
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }

  /// * Search Button Event
  /// Will Slide Transit into Lawyer List Screen
  void _handleSearchPressed() {
    Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => LawyerListPage(
                  district: districts[_selectedDistrict],
                ),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            },
          ),
        );
  }

  /// * Handle Select District Button Tap
  void _handleSelectDistrict(BuildContext context) async {
    // ! Not clean - Fix
    List<int> _selectedDistrictObj = [_selectedDistrict];
    await showDialog(
      builder: (_) => RadioDialog(
            options: districts,
            selectedIndexObj: _selectedDistrictObj,
            title: "Select District",
          ),
      context: context,
    );
    setState(() {
      _selectedDistrict = _selectedDistrictObj[0];
    });
  }
}
