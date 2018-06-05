import 'package:flutter/material.dart';

import 'package:lawyer_app/windows/lawyer_list.dart' as window_list;
import 'package:lawyer_app/helper_widgets/rounded_button.dart';
import 'package:lawyer_app/helper_widgets/container_card.dart';

/// All content of [WelcomePage] directory part
/// Contains
/// * Header - Image
/// * Center - Area with background image with search box
class WelcomeDirectory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomeDirectoryState();
}

/// [State] of [_WelcomeContent]
class _WelcomeDirectoryState extends State<WelcomeDirectory> {
  List<String> _districts = [
    "Gampaha",
    "Colombo",
    "Kalutara",
    "",
    "Matale",
    "Kandy",
    "Nuwara Eliya",
    "",
    "Badulla",
    "Monaragala",
    "",
    "Hambantota",
    "Matara",
    "Galle",
    "",
    "Anuradhapura",
    "Polonnaruwa",
    "",
    "Kegalle",
    "Ratnapura",
    "",
    "Jaffna",
    "Kilinochchi",
    "Mannar",
    "Mullaitivu",
    "Vavuniya",
    "",
    "Puttalam",
    "Kurunegala",
    "",
    "Trincomalee",
    "Batticaloa",
    "Ampara",
  ];
  int _selectedDistrict = 0;

  @override
  Widget build(BuildContext context) {
    return _buildCenterContent(context);
  }

  /// Central part Image
  /// Consist of SearchBox and SearchButton
  /// TODO: Add a more beautiful Image
  Widget _buildCenterContent(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/background.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: new ContainerCard(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildCardTitle(context),
              const Divider(),
              _buildSearchLabel(context),
              _buildDistrictField(context),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new RoundedButton(
                    text: "Pinned",
                    onPressed: () => null,
                  ),
                  new RoundedButton(
                    text: "Search",
                    onPressed: _handleSearchPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card Title
  Widget _buildCardTitle(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        "Find your lawyer",
        style: const TextStyle(
          fontSize: 24.0,
          fontFamily: "serif",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Search Button Event
  /// Will Slide Transit into [window_list.LawyerListPage]
  void _handleSearchPressed() {
    Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => new window_list.LawyerListPage(
                  district: _districts[_selectedDistrict],
                ),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
  }

  /// Search Field Layout
  /// TODO: Add an Action to Select a district
  Widget _buildDistrictField(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: new RaisedButton(
        child: new Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: new Text(_districts[_selectedDistrict]),
        ),
        onPressed: () => _handleSelectDistrict(context),
      ),
    );
  }

  void _handleSelectDistrict(BuildContext context) {
    List<Widget> _options = [];
    for (int i = 0; i < _districts.length; i++) {
      if (_districts[i] == "") {
        _options.add(new Divider());
        continue;
      }
      _options.add(
        new InkWell(
          onTap: () {
            setState(() {
              _selectedDistrict = i;
            });
            Navigator.pop(context);
          },
          child: new Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  decoration: new ShapeDecoration(
                    shape: new CircleBorder(
                      side: new BorderSide(
                        width: 10.0,
                        color: (i == _selectedDistrict)
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(_districts[i]),
                )
              ],
            ),
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (_) => new SimpleDialog(
            children: _options,
            title: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Select District"),
                  new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () => Navigator.pop(context))
                ],
              ),
            ),
          ),
    );
  }

  /// Search Label Layout
  Widget _buildSearchLabel(BuildContext context) {
    return new Container(
      child: new Text(
        "Select District",
        style: new TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
    );
  }
}
