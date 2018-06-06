import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

import 'package:lawyer_app/utils/lawnet_search.dart' show Requests;

import 'package:lawyer_app/dialogs/search_settings.dart' show SettingsDialog;

import 'package:lawyer_app/widgets/container_card.dart' show ContainerCard;
import 'package:lawyer_app/widgets/rounded_button.dart' show RoundedButton;

/// * Window to handle all lawnet actions
/// Will be used to search lawnet.lk
/// Theme is different than normal
class StartupLawnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      child: StartupLawnetContent(),
      data: themeData,
    );
  }

  StartupLawnet({@required this.themeData});
  final ThemeData themeData;
}

class StartupLawnetContent extends StatefulWidget {
  State<StartupLawnetContent> createState() => StartupLawnetContentState();
}

/// All will be build here
class StartupLawnetContentState extends State<StartupLawnetContent> {
  // Control textbox
  TextEditingController _textcontroller;
  // Search options
  List<bool> _searchOptions = [false, true, false];
  // Browser to send http posts
  Requests _virtualBrowser;
  // All results
  Widget _searchResults;
  // No results found yet
  final _searchingIndicator = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    // Initialize virtual browser, text box and search results
    _virtualBrowser = Requests();
    _textcontroller = TextEditingController();
    // No search results
    _searchResults = Container();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Disconnect browser
    try {
      _virtualBrowser.client.close();
    } catch (Exception) {
      // ! Error Occured - Disconnected while recieving data.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/lawnet_background.jpg"),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: ListView(
        children: <Widget>[
          _buildSearchbar(),
          _searchResults,
        ],
      ),
    );
  }

  /// * Search bar at top
  Widget _buildSearchbar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
      child: ContainerCard(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Lawnet.lk",
                ),
                controller: _textcontroller,
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Tooltip(
                  message: "Visit Web Site",
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: defaultTargetPlatform == TargetPlatform.iOS
                        ? Icon(CupertinoIcons.home)
                        : Icon(Icons.home),
                    onPressed: _handleVisitWeb,
                  ),
                ),
                Tooltip(
                  message: "Change Search Settings",
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: defaultTargetPlatform == TargetPlatform.iOS
                        ? Icon(CupertinoIcons.ellipsis)
                        : Icon(Icons.settings),
                    onPressed: () => _handleSearchSettings(context),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RoundedButton(
                    onPressed: _handleSearch,
                    text: "Search",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// * Each search result
  /// Will be based off 'block'
  /// When clicked, will go to the corresponding page
  Widget _buildSearchReult(Map<String, String> block) {
    return InkWell(
      onTap: () => _launchUrl("${block["link"]}"),
      child: ContainerCard(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "${block["title"]} [${block["date"]}]",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "${block["content"]}",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Search button event
  void _handleSearch() async {
    if (_textcontroller.text == "") {
      Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Nothing  Entered to Search"),
          ));
      return;
    }

    setState(() {
      // Still searching
      _searchResults = _searchingIndicator;
    });
    // Search
    List data = [];
    List<Widget> _searchResultList = [];

    try {
      data = await this._virtualBrowser.post(
          this._textcontroller.text,
          this._searchOptions[0],
          this._searchOptions[1],
          this._searchOptions[2]);
    } catch (e) {
      // ! Error : Error while Searching - No Internet?
      print(e);
      _searchResultList = [
        ContainerCard(
          child: Center(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Error while Searching.\n"
                  "Do you have an active network connection?\n\n"),
            ),
          ),
        ),
      ];
      data = [];
    }

    // Searched
    for (Map block in data) {
      _searchResultList.add(_buildSearchReult(block));
    }

    if (_searchResultList.length == 0) {
      // ! Error : No Search Results
      _searchResultList.add(
        ContainerCard(
          child: Center(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No Results Found"),
            ),
          ),
        ),
      );
    }

    // Now show results
    setState(
      () {
        _searchResults = Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: _searchResultList,
          ),
        );
      },
    );
  }

  // Visit web site
  void _handleVisitWeb() {
    String url = "https://www.lawnet.gov.lk/";
    _launchUrl(url);
  } // Launch a url

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      print(url);
    } else {
      /// ! Error Occured : Launch Failed
      return;
    }
  }

  // Show search settings dialog
  void _handleSearchSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SettingsDialog(_searchOptions),
    );
  }
}
