import 'package:flutter/material.dart';

import 'package:lawyer_app/helper_widgets/container_card.dart';
import 'package:lawyer_app/helper_widgets/rounded_button.dart';

class WelcomeLawnet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WelcomeLawnetState();
}

class _WelcomeLawnetState extends State<WelcomeLawnet> {
  TextEditingController _textcontroller;

  @override
  void initState() {
    _textcontroller = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
            primaryColor: Colors.brown,
            accentColor: Colors.amberAccent,
          ),
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/lawnet_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: new Column(
          children: <Widget>[
            _buildSearchbar(),
            new Expanded(
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ),
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
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RoundedButton(
                onPressed: () => null,
                text: "Search",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
