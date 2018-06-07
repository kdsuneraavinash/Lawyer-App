import 'package:flutter/material.dart';

/// * Search settings dialog
class SettingsDialog extends StatefulWidget {
  SettingsDialog(this._searchOptions);
  final List _searchOptions;

  @override
  State<StatefulWidget> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        _buildCheckBox(context, "Search Exact Text",
            "Results will contain the exact search text.", 0),
        _buildCheckBox(
            context, "Search in Titles", "Every title will be searched.", 1),
        _buildCheckBox(context, "Search in Content",
            "All of the content will be searched.", 2),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlineButton(
            child: Text("OK"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }

  /// * Build Check box
  Widget _buildCheckBox(
      BuildContext context, String text, String message, int index) {
    return CheckboxListTile(
      title: Text(text),
      subtitle: Text(message),
      isThreeLine: true,
      onChanged: (v) => _handleSearchOptionCheck(index, v),
      value: this.widget._searchOptions[index],
      activeColor: Theme.of(context).primaryColor,
    );
  }

  /// * Each Handler
  void _handleSearchOptionCheck(int index, bool checked) {
    setState(
      () {
        this.widget._searchOptions[index] = checked;
      },
    );
  }
}
