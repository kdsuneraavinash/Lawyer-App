import 'package:flutter/material.dart';

class PushButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic function = this.onPressed;

    if (!this.enabled) function = null;
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0 - this.size / 2, 0.0, 10.0),
      child: RaisedButton(
        padding: EdgeInsets.all(20.0),
        child: Icon(
          icon,
          size: this.size,
          color: this.color,
        ),
        shape: CircleBorder(),
        onPressed: function,
        color: Theme.of(context).cardColor,
        splashColor: this.splashColor,
        disabledColor: Colors.grey,
      ),
    );
  }

  PushButton(
      {@required this.icon,
      this.color,
      this.size = 40.0,
      this.onPressed,
      this.splashColor,
      this.enabled=true});
  final IconData icon;
  final Color color;
  final Color splashColor;
  final double size;
  final VoidCallback onPressed;
  final bool enabled;
}
