import 'package:flutter/material.dart';

import 'package:lawyer_app/helper_widgets/container_card.dart';
import 'package:lawyer_app/helper_widgets/rounded_button.dart';

import 'package:lawyer_app/lawnet_requests.dart';
import 'package:url_launcher/url_launcher.dart';

/// Window to handle all lawnet actions
/// Will be used to search lawnet.lk
/// Theme is different than normal
class WelcomeLawnet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
            primaryColor: Colors.brown[900],
            accentColor: Colors.amberAccent,
          ),
      child: new _WelcomeLawnetContent(),
    );
  }
}

class _WelcomeLawnetContent extends StatefulWidget {
  State<_WelcomeLawnetContent> createState() =>
      new _WelcomeLawnetContentState();
}

/// All will be bulild here
class _WelcomeLawnetContentState extends State<_WelcomeLawnetContent> {
  // Control textbox
  TextEditingController _textcontroller;
  // Search options
  List<bool> _searchOptions = [false, true, false];
  // Browser to send http posts
  Requests _virtualBrowser;
  // All results
  Widget _searchResults;
  // No results found yet
  final _searchingIndicator = new Center(
    child: new CircularProgressIndicator(),
  );

  @override
  void initState() {
    // Initialize virtual browser, text box and search results
    _virtualBrowser = new Requests();
    _textcontroller = new TextEditingController();
    // No search results
    _searchResults = new Container();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Disconnect browser
    try{
    _virtualBrowser.client.close();
    }catch(Exception){
      print("Disconnected while recieving data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/lawnet_background.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: new ListView(
        children: <Widget>[
          _buildSearchbar(),
          _searchResults,
        ],
      ),
    );
  }

  /// Search bar at top
  Widget _buildSearchbar() {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
      child: new ContainerCard(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: new TextField(
                decoration: const InputDecoration(
                  hintText: "Search Lawnet.lk",
                ),
                controller: _textcontroller,
                onSubmitted: (_) => _handleSearch,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Tooltip(
                  message: "Visit Web Site",
                  child: new IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: new Icon(Icons.web),
                    onPressed: _handleVisitWeb,
                  ),
                ),
                new Tooltip(
                  message: "Change Search Settings",
                  child: new IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: new Icon(Icons.settings),
                    onPressed: () => _handleSearchSettings(context),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RoundedButton(
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

  /// Each search result
  /// Will be based off 'block'
  /// When clicked, will go to the corresponding pdf
  Widget _buildSearchReult(Map<String, String> block) {
    return new InkWell(
      onTap: () => _launchUrl("${block["link"]}"),
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "${block["title"]} [${block["date"]}]",
                style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              decoration: new BoxDecoration(
                color: Colors.grey[100],
                border: new Border.all(
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "${block["content"]}",
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            new Divider(),
          ],
        ),
      ),
    );
  }

  /// Search button event
  void _handleSearch() async {
    setState(() {
      // Still searching
      _searchResults = _searchingIndicator;
    });
    // Search
    List data = await this._virtualBrowser.post(_textcontroller.text,
        this._searchOptions[0], this._searchOptions[1], this._searchOptions[2]);
    List<Widget> _searchResultList = [];

    // Searched
    for (Map block in data) {
      _searchResultList.add(_buildSearchReult(block));
    }

    // Now show results
    setState(
      () {
        _searchResults = new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ContainerCard(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: _searchResultList,
              ),
            ),
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
      // TODO: Remove this line
      print("Launch Failed :\n$url");
      return;
    }
  }

  // Show search settings dialog
  void _handleSearchSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new _SettingsDialog(_searchOptions),
    );
  }
}

/// Search settings dialog
class _SettingsDialog extends StatefulWidget {
  _SettingsDialog(this._searchOptions);
  final List _searchOptions;

  @override
  State<StatefulWidget> createState() {
    return _SettingsDialogState(_searchOptions);
  }
}

class _SettingsDialogState extends State<_SettingsDialog> {
  _SettingsDialogState(this._searchOptions);
  List _searchOptions;

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      children: <Widget>[
        _buildCheckBox(context, "Search Exact Text",
            "Results will contain the exact search text.", 0),
        _buildCheckBox(
            context, "Search in Titles", "Every title will be searched.", 1),
        _buildCheckBox(context, "Search in Content",
            "All of the content will be searched.", 2),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new FlatButton(
            child: const Text("OK"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }

  Widget _buildCheckBox(
      BuildContext context, String text, String message, int index) {
    return new CheckboxListTile(
      title: new Text(text),
      subtitle: new Text(message),
      isThreeLine: true,
      onChanged: (v) => _handleSearchOptionCheck(index, v),
      value: _searchOptions[index],
      activeColor: Theme.of(context).primaryColor,
    );
  }

  void _handleSearchOptionCheck(int index, bool checked) {
    setState(
      () {
        this._searchOptions[index] = checked;
      },
    );
  }
}
