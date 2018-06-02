import 'package:flutter/material.dart';

class PushButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(0.0, 20.0 - this.size / 2, 0.0, 10.0),
      child: RaisedButton(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          icon,
          size: this.size,
          color: this.color,
        ),
        shape: new CircleBorder(),
        onPressed: this.onPressed,
        color: Theme.of(context).cardColor,
        splashColor: this.splashColor,
      ),
    );
  }

  PushButton(
      {@required this.icon,
      this.color,
      this.size = 40.0,
      this.onPressed,
      this.splashColor});
  final IconData icon;
  final Color color;
  final Color splashColor;
  final double size;
  final VoidCallback onPressed;
}
