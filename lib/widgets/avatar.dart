import 'package:flutter/material.dart';

import 'package:lawyer_app/utils/lawyer.dart' show Sex;

/// Lawyer Profile Image
/// Image depend on Lawyer Gender
/// TODO: Change Profile Image if necessary
class LawyerAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Image.asset(
        (sex == Sex.MALE) ? "assets/images/male.png" : "assets/images/female.png",
        width: this.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  LawyerAvatar(this.sex, this.width);
  final Sex sex;
  final double width;
}
