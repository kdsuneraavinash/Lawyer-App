import 'package:flutter/material.dart';

import 'package:lawyer_app/lawyer.dart';

import 'package:lawyer_app/helper_widgets/avatar.dart';

/// Single Lawyer Tile
/// Display a Tile Containing Abstract Lawyer Info
class LawyerListTile extends StatelessWidget {
  LawyerListTile({@required this.lawyer});
  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(4.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                child: new Hero(
                  tag: this.lawyer,
                  child: new LawyerAvatar(lawyer.sex, 50.0),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: new Text(
                        this.lawyer.name,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    new Text(
                      this.lawyer.title,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          new Divider(
            indent: 80.0,
            height: 3.0,
          ),
        ],
      ),
    );
  }
}
