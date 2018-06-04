import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      shape: new StadiumBorder(),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).canvasColor,
      child: new Text(this.text),
      onPressed: this.onPressed,
    );
  }

  RoundedButton({this.onPressed, this.text});
  final VoidCallback onPressed;
  final String text;
}
