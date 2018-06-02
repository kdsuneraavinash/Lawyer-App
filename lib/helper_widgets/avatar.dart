import 'package:flutter/material.dart';
import 'package:lawyer_app/lawyer.dart';

/// Lawyer Profile Image
/// Image depend on Lawyer Gender
/// TODO: Change Profile Image if necessary
class LawyerAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(5.0),
      child: new Image.asset(
        (sex == Sex.MALE) ? "images/male.png" : "images/female.png",
        width: this.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  LawyerAvatar(this.sex, this.width);
  final Sex sex;
  final double width;
}
