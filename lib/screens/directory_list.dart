import 'package:flutter/material.dart';

import 'package:lawyer_app/screens/details.dart' show LawyerDetailsPage;
import 'package:lawyer_app/widgets/list_tile.dart' show LawyerListTile;
import 'package:lawyer_app/utils/lawyer.dart' show Lawyer;

/// * This is the Whole page for lawyer list.
/// Contains a list with each lawyer's name and a short description.
///
/// TODO: Connect with a database to retrieve data.
class LawyerListPage extends StatelessWidget {
  // ! Unclean : Find a good way to change entire app theme
  LawyerListPage({@required this.district, @required this.themeData});
  final String district;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${this.district}"),
        ),
        body: LawyerListPageContent(themeData: this.themeData),
      ),
      data: this.themeData,
    );
  }
}

/// * Creates lawyer list body [StatefulWidget].
class LawyerListPageContent extends StatefulWidget {
  LawyerListPageContent({@required this.themeData});
  final ThemeData themeData;

  @override
  LawyerListPageContentState createState() => LawyerListPageContentState();
}

/// Contains State of Content.
///
/// This will create a ListView.builder to increase efficiency.
/// At the moment this will also create lawyers to hold all lawyer info.
///
/// TODO: Remove manually adding to lawyers and use Databases instead.
class LawyerListPageContentState extends State<LawyerListPageContent> {
  List _lawyers = [];

  @override
  void initState() {
    _lawyers = Lawyer.createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _lawyers.length,
      itemBuilder: (_, index) => LawyerListItem(
            lawyer: _lawyers[index],
            themeData: this.widget.themeData,
          ),
    );
  }
}

/// * This holds each [StatefulWidget] of each lawyer item.
/// This will only hold Lawyer name, short description and a small coloured circle.
/// Will also pass lawyer info for LawyerListItem.
class LawyerListItem extends StatefulWidget {
  LawyerListItem({this.lawyer, this.themeData});
  final Lawyer lawyer;
  final ThemeData themeData;

  @override
  State createState() => LawyerListItemState();
}

/// * This will hold lawyer list item.
/// Currently each item is a LawyerListTile.
///
/// This will also handle Tapping on LawyerListTile.
class LawyerListItemState extends State<LawyerListItem> {
  void _handleListTileOnTap() {
    Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => LawyerDetailsPage(
                // ! Unclean : Find a good way to change entire app theme
                lawyer: this.widget.lawyer,
                themeData: this.widget.themeData),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: LawyerListTile(lawyer: this.widget.lawyer),
      highlightColor: Theme.of(context).accentColor,
      splashColor: Theme.of(context).accentColor,
      onTap: _handleListTileOnTap,
    );
  }
}
