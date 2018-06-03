import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lawyer_app/lawyer.dart';
import 'package:lawyer_app/helper_widgets/push_button.dart';
import 'package:lawyer_app/helper_widgets/avatar.dart';

enum LaunchMethod { MAIL, CALL, MESSAGE }

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
      children: _buildInfoList(context),
    );
  }

  List<Widget> _buildInfoList(BuildContext context) {
    List<Widget> column = [
      new _Header(lawyer: this.lawyer),
    ];

    _addToColumn(column, "Name", this.lawyer.name, Icons.person);
    _addToColumn(column, "Title", this.lawyer.title, Icons.work);
    _addToColumn(column, "Address", this.lawyer.address, Icons.location_city);
    _addToColumn(column, "Phone Number", this.lawyer.telephone, Icons.phone);
    _addToColumn(column, "E Mail", this.lawyer.email, Icons.email);

    return column;
  }

  void _addToColumn(
      List<Widget> column, String title, dynamic value, IconData icon) {
    if (value != null) {
      column.add(
        new ListTile(
          leading: new Icon(icon),
          title: new Text(title),
          subtitle: new Text(value),
        ),
      );
    }
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
                enabled: (this.lawyer.telephone != null),
                onPressed: () => launchAction(this.lawyer.telephone, LaunchMethod.MESSAGE),
              ),
              new PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.phone
                    : Icons.phone,
                color: Colors.green,
                splashColor: Colors.lightGreen,
                size: 40.0,
                enabled: (this.lawyer.telephone != null),
                onPressed: () => launchAction(this.lawyer.telephone, LaunchMethod.CALL),
              ),
              new PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? Icons.alternate_email
                    : Icons.email,
                color: Colors.blue,
                splashColor: Colors.lightBlue,
                size: 25.0,
                enabled: (this.lawyer.email != null),
                onPressed: () => launchAction(this.lawyer.email, LaunchMethod.MAIL),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void launchAction(dynamic value, LaunchMethod method) async {
    if (value == null) return;
    String url;

    switch (method) {
      case LaunchMethod.CALL:
        url = "tel:$value";
        break;
      case LaunchMethod.MESSAGE:
        url = "sms:$value";
        break;
      case LaunchMethod.MAIL:
        url = "mailto:$value";
        break;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return;
    }
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
