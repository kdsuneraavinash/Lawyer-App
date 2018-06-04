import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new RaisedButton(
        shape: new StadiumBorder(),
        color: (this.color == null) ? Theme.of(context).primaryColor : this.color,
        textColor: (this.fontcolor == null)
            ? Theme.of(context).canvasColor
            : this.fontcolor,
        child: new Text(this.text),
        onPressed: this.onPressed,
      ),
    );
  }

  RoundedButton(
      {@required this.onPressed,
      @required this.text,
      this.color,
      this.fontcolor});
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color fontcolor;
}
