import 'package:flutter/material.dart';

import '../login.dart';
import 'login_form_components/login_form.dart';

class LoginForm extends StatelessWidget {
  final LoginPresenter presenter;
  final BoxConstraints constraints;
  final BorderRadius borderRadius;
  final double margin;

  const LoginForm(
      {required this.presenter,
      required this.constraints,
      required this.margin,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return constraints.maxWidth > 950
        ? DesktopLoginForm(
            presenter: presenter,
            constraints: constraints,
            margin: margin,
            borderRadius: borderRadius)
        : constraints.maxWidth > 600
            ? TabletLoginForm(
                presenter: presenter,
                constraints: constraints,
                margin: margin,
                borderRadius: borderRadius)
            : MobileLoginForm(
                presenter: presenter,
                constraints: constraints,
                margin: margin,
                borderRadius: borderRadius);
  }
}
