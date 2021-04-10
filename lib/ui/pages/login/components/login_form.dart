import 'package:flutter/material.dart';

import 'login_form_components/login_form.dart';

class LoginForm extends StatelessWidget {
  final BoxConstraints constraints;
  final BorderRadius borderRadius;
  final double margin;

  const LoginForm(
      {required this.constraints,
      required this.margin,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return constraints.maxWidth > 950
        ? DesktopLoginForm(
            constraints: constraints,
            margin: margin,
            borderRadius: borderRadius)
        : constraints.maxWidth > 600
            ? TabletLoginForm(
                constraints: constraints,
                margin: margin,
                borderRadius: borderRadius)
            : MobileLoginForm(
                constraints: constraints,
                margin: margin,
                borderRadius: borderRadius);
  }
}
