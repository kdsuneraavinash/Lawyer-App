import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';

import 'package:lawyer_app/lawyer.dart';
import 'package:lawyer_app/helper_widgets/push_button.dart';
import 'package:lawyer_app/helper_widgets/avatar.dart';

class LawyerDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(lawyer.name),
        elevation: 0.0,
      ),
      body: new _PageContent(
        lawyer: this.lawyer,
      ),
    );
  }

  LawyerDetailsPage({@required this.lawyer});
  final Lawyer lawyer;
}

class _PageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new _Header(lawyer: this.lawyer),
        new ListTile(
          leading: new Icon(Icons.location_city),
          title: new Text("Address"),
          subtitle: new Text("344/1, Moonamalgahawatta, DuwaTemple Rd."),
        ),
        new ListTile(
          leading: new Icon(Icons.call),
          title: new Text("Phone Number"),
          subtitle: new Text("076-8336850"),
        ),
        new ListTile(
          leading: new Icon(Icons.email),
          title: new Text("E Mail"),
          subtitle: new Text("kdsuneraavinash@gmail.com"),
        ),
        new ListTile(
          leading: new Icon(Icons.work),
          title: new Text("Title"),
          subtitle: new Text("LLB, attorny-at-law"),
        ),
      ],
    );
  }

  _PageContent({@required this.lawyer});
  final Lawyer lawyer;
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          height: 180.0,
        ),
        _buildHeaderImage(context),
        new Padding(
          padding: const EdgeInsets.only(top: 140.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.conversation_bubble
                    : Icons.chat,
                color: Colors.deepOrange,
                splashColor: Colors.orange,
                size: 25.0,
                onPressed: () => null,
              ),
              new PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.phone
                    : Icons.phone,
                color: Colors.green,
                splashColor: Colors.lightGreen,
                size: 40.0,
                onPressed: () => null,
              ),
              new PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? Icons.alternate_email
                    : Icons.email,
                color: Colors.blue,
                splashColor: Colors.lightBlue,
                size: 25.0,
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0),
            child: new Divider(
              color: Colors.white,
            ),
          ),
          new Center(
            child: new Hero(
              tag: this.lawyer,
              child: new LawyerAvatar(lawyer.sex, 120.0),
            ),
          ),
        ],
      ),
    );
  }

  _Header({@required this.lawyer});
  final Lawyer lawyer;
}
