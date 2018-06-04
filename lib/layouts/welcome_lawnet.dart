import 'package:flutter/material.dart';

import 'package:lawyer_app/helper_widgets/container_card.dart';
import 'package:lawyer_app/helper_widgets/rounded_button.dart';

import 'package:lawyer_app/lawnet_requests.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _WelcomeLawnetContentState extends State<_WelcomeLawnetContent> {
  TextEditingController _textcontroller;
  List<bool> _searchOptions = [false, true, false];
  Requests _virtualBrowser;
  Widget _searchResults;
  final _searchingIndicator = new Center(
    child: new CircularProgressIndicator(),
  );

  @override
  void initState() {
    _virtualBrowser = new Requests();
    _textcontroller = new TextEditingController();
    _searchResults = new Container();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _virtualBrowser.client.close();
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

  void _handleSearch() async {
    setState(() {
      _searchResults = _searchingIndicator;
    });
    List data = await this._virtualBrowser.post(_textcontroller.text,
        this._searchOptions[0], this._searchOptions[1], this._searchOptions[2]);
    List<Widget> _searchResultList = [];

    for (Map block in data) {
      Widget _searchResult = new Container(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "${block["title"]} [${block["asp_date"]}]",
                style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new Padding(
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
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "${block["asp_res_url_href"]}",
                style: new TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic
                ),
                textAlign: TextAlign.right,
              ),
            ),
            new Divider(),
          ],
        ),
      );
      _searchResultList.add(_searchResult);
    }

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

  void _handleVisitWeb() async {
    String url = "https://www.lawnet.gov.lk/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return;
    }
  }

  void _handleSearchSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new _SettingsDialog(_searchOptions),
    );
  }
}

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
