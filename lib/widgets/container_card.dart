import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(this.cornerRadius)),
        color: Theme.of(context).cardColor,
      ),
      child: this.child,
    );
  }

  ContainerCard({this.child, this.cornerRadius = 5.0});
  final double cornerRadius;
  final Widget child;
}
