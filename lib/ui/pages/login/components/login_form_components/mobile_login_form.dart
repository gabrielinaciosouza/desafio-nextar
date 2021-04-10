import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../helpers/helpers.dart';
import '../../components/components.dart';
import 'login_form_fields.dart';

class MobileLoginForm extends StatelessWidget {
  const MobileLoginForm(
      {required this.constraints,
      required this.margin,
      required this.borderRadius});

  final BoxConstraints constraints;
  final double margin;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * margin,
            vertical: constraints.maxWidth * margin),
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * .1),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * .03,
            ),
            ResponsiveHeadline6(
              text: R.strings.login,
              color: Theme.of(context).primaryColorDark,
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            LoginFormFields(constraints: constraints)
          ],
        ),
      ),
    );
  }
}
