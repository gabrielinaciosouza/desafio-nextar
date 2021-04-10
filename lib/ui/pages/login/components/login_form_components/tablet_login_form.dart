import 'package:flutter/material.dart';

import 'login_form_fields.dart';

class TabletLoginForm extends StatelessWidget {
  const TabletLoginForm({
    required this.constraints,
    required this.margin,
    required this.borderRadius,
  });

  final BoxConstraints constraints;
  final double margin;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * .12,
        ),
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
            AspectRatio(
              aspectRatio: 2,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('lib/ui/assets/logo.png'),
              ),
            ),
            LoginFormFields(constraints: constraints)
          ],
        ),
      ),
    );
  }
}
