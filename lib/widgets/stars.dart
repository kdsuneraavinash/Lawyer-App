import 'package:flutter/material.dart';

/// Single Star
/// Only 2 states - Coloured or Uncoloured
/// TODO: Add half star if necessary
class Star extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      this.isFilled ? Icons.star : Icons.star_border,
      size: 14.0,
    );
  }

  Star(this.isFilled);
  final bool isFilled;
}

/// Set of 3 stars
class StarRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Star(this.stars > 0),
        Star(this.stars > 1),
        Star(this.stars > 2),
      ],
    );
  }

  StarRow(this.stars);
  final int stars;
}
