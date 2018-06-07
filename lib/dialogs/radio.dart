import 'package:flutter/material.dart';

/// * Dialog Box to select from
class RadioDialog extends StatefulWidget {
  // TODO: Find a better way to pass as an mutable object
  // ! Not clean : Must Fix - selectedIndexObj is passed to edit value
  RadioDialog(
      {@required this.options,
      @required this.selectedIndexObj,
      @required this.title});
  final List<String> options;
  final List<int> selectedIndexObj;
  final String title;

  @override
  _RadioDialogState createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  /// * Build dialog box
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: _buildOptionsList(),
      title: Padding(
          padding: EdgeInsets.all(8.0),
          child: new OutlineButton.icon(
            icon: Icon(Icons.done),
            label: Text(
              "Done",
              style: Theme.of(context).textTheme.title,
            ),
            onPressed: () => Navigator.pop(context),
          )),
    );
  }

  /// * Build an list of option buttons
  /// Each empty string will be a divider
  List<Widget> _buildOptionsList() {
    List<Widget> _widgetList = [];
    // Loop over all strings
    for (int index = 0; index < this.widget.options.length; index++) {
      if (this.widget.options[index] == "") {
        // Empty String
        _widgetList.add(Divider());
        continue;
      }
      // Non Empty String
      _widgetList.add(_buildOptionButton(
        context: context,
        text: this.widget.options[index],
        index: index,
        selected: (this.widget.selectedIndexObj[0] == index),
      ));
    }
    return _widgetList;
  }

  /// * Build Single Option Button
  Widget _buildOptionButton(
      {@required BuildContext context,
      @required String text,
      @required int index,
      bool selected = false}) {
    return InkWell(
      onTap: () => _handleOptionClick(context, index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    width: 10.0,
                    color: (index == this.widget.selectedIndexObj[0])
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(this.widget.options[index]),
            ),
          ],
        ),
      ),
    );
  }

  /// * Handler for option button press
  /// Will Update User Interface and Exit
  void _handleOptionClick(BuildContext context, int index) {
    setState(() {
          this.widget.selectedIndexObj[0] = index;
        });
  }
}
