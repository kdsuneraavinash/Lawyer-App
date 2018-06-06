import 'package:flutter/material.dart';

import 'package:lawyer_app/utils/lawyer.dart' show Lawyer;

import 'package:lawyer_app/widgets/avatar.dart' show LawyerAvatar;

/// * Single Lawyer Tile
/// Display a Tile Containing Abstract Lawyer Info
class LawyerListTile extends StatelessWidget {
  LawyerListTile({@required this.lawyer});
  final Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 10.0),
                child: Hero(
                  tag: this.lawyer,
                  child: LawyerAvatar(lawyer.sex, 50.0),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        this.lawyer.name,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      this.lawyer.title,
                      style: TextStyle(
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
          Divider(
            indent: 80.0,
            height: 3.0,
          ),
        ],
      ),
    );
  }
}
