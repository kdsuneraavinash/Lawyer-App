import 'package:flutter/material.dart';

import 'package:lawyer_app/windows/window_details.dart';
import 'package:lawyer_app/helper_widgets/list_tile.dart';
import 'package:lawyer_app/lawyer.dart';

/// This is the Whole page for lawyer list.
/// Contains a list with each lawyer's name and a short description.
///
/// TODO: Connect with a database to retrieve data.
class LawyerListPage extends StatelessWidget {
  LawyerListPage({@required this.district});
  final String district;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lawyers in ${this.district}"),
      ),
      body: new _PageContent(),
    );
  }
}

/// Creates lawyer list body [StatefulWidget].
class _PageContent extends StatefulWidget {
  @override
  _PageContentState createState() => new _PageContentState();
}

/// Contains [State] of [_Content].
///
/// This will create a [ListView.builder] to increase efficiency.
/// At the moment this will also create [_lawyers] to hold all lawyer info.
///
/// TODO: Remove manually adding to [_lawyers] and use Databases instead.
class _PageContentState extends State<_PageContent> {
  List _lawyers = [];

  @override
  void initState() {
    _lawyers = Lawyer.createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: _lawyers.length,
      itemBuilder: (_, index) => new _ListItem(
            lawyer: _lawyers[index],
          ),
    );
  }
}

/// This holds each [StatefulWidget] of each lawyer item.
/// This will only hold Lawyer name, short description and a small coloured circle.
/// Will also pass lawyer info for [_LawyerListItem].
class _ListItem extends StatefulWidget {
  _ListItem({this.lawyer});
  final Lawyer lawyer;

  @override
  State createState() => new _ListItemState(lawyer: lawyer);
}

/// This will hold lawyer list item.
/// Currently each item is a [LawyerListTile].
///
/// This will also handle Tapping on [LawyerListTile].
class _ListItemState extends State<_ListItem> {
  _ListItemState({this.lawyer});
  final Lawyer lawyer;

  void _handleListTileOnTap() {
    Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => new LawyerDetailsPage(lawyer: lawyer),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: LawyerListTile(lawyer: lawyer),
      highlightColor: Theme.of(context).accentColor,
      splashColor: Theme.of(context).accentColor,
      onTap: _handleListTileOnTap,
    );
  }
}
