import 'package:flutter/material.dart';

import 'login_form_fields.dart';

class DesktopLoginForm extends StatelessWidget {
  const DesktopLoginForm(
      {required this.constraints,
      required this.margin,
      required this.borderRadius});

  final BoxConstraints constraints;
  final double margin;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * .12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('lib/ui/assets/logo.png'),
                ),
              ),
            ),
          ),
          VerticalDivider(
            color: Theme.of(context).primaryColorDark,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(constraints.maxWidth * .04),
                child: LoginFormFields(constraints: constraints)),
          ),
        ],
      ),
    );
  }
}
