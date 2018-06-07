import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lawyer_app/utils/lawyer.dart' show Lawyer;

import 'package:lawyer_app/widgets/push_button.dart' show PushButton;
import 'package:lawyer_app/widgets/avatar.dart' show LawyerAvatar;

enum LaunchMethod { MAIL, CALL, MESSAGE }

/// * Page to show details
/// Will show each lawyer details like phone number ...
class LawyerDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lawyer.name),
        elevation: 0.0,
      ),
      body: LawyerDetailsPageContent(
        lawyer: this.lawyer,
      ),
    );
  }

  LawyerDetailsPage({@required this.lawyer});
  final Lawyer lawyer;
}

class LawyerDetailsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildInfoList(context),
    );
  }

  /// * Build the column which will include all info list tiles
  List<Widget> _buildInfoList(BuildContext context) {
    List<Widget> column = [
      LawyerDetailsPageHeader(lawyer: this.lawyer),
    ];

    _addToColumn(column, "Name", this.lawyer.name, Icons.person);
    _addToColumn(column, "Title", this.lawyer.title, Icons.work);
    _addToColumn(column, "Address", this.lawyer.address, Icons.location_city);
    _addToColumn(column, "Phone Number", this.lawyer.telephone, Icons.phone);
    _addToColumn(column, "E Mail", this.lawyer.email, Icons.email);

    return column;
  }

  /// * add to Column as a list tile
  void _addToColumn(
      List<Widget> column, String title, dynamic value, IconData icon) {
    if (value != null) {
      column.add(
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(value),
        ),
      );
    }
  }

  LawyerDetailsPageContent({@required this.lawyer});
  final Lawyer lawyer;
}

/// * Header which includes Person Avatar and 3 push buttons
class LawyerDetailsPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          height: 180.0,
        ),
        _buildHeaderImage(context),
        Padding(
          padding: EdgeInsets.only(top: 140.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.conversation_bubble
                    : Icons.chat,
                color: Colors.deepOrange,
                splashColor: Colors.orange,
                size: 25.0,
                enabled: (this.lawyer.telephone != null),
                onPressed: () =>
                    launchAction(this.lawyer.telephone, LaunchMethod.MESSAGE),
              ),
              PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.phone
                    : Icons.phone,
                color: Colors.green,
                splashColor: Colors.lightGreen,
                size: 40.0,
                enabled: (this.lawyer.telephone != null),
                onPressed: () =>
                    launchAction(this.lawyer.telephone, LaunchMethod.CALL),
              ),
              PushButton(
                icon: defaultTargetPlatform == TargetPlatform.iOS
                    ? Icons.alternate_email
                    : Icons.email,
                color: Colors.blue,
                splashColor: Colors.lightBlue,
                size: 25.0,
                enabled: (this.lawyer.email != null),
                onPressed: () =>
                    launchAction(this.lawyer.email, LaunchMethod.MAIL),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// * Launch in default app
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          Center(
            child: Hero(
              tag: this.lawyer,
              child: LawyerAvatar(lawyer.sex, 120.0),
            ),
          ),
        ],
      ),
    );
  }

  LawyerDetailsPageHeader({@required this.lawyer});
  final Lawyer lawyer;
}
