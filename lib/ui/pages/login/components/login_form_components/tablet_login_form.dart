import 'package:flutter/material.dart';

import '../../login.dart';
import 'login_form_fields.dart';

class TabletLoginForm extends StatelessWidget {
  final BoxConstraints constraints;
  final double margin;
  final BorderRadius borderRadius;
  final LoginPresenter presenter;

  const TabletLoginForm(
      {required this.constraints,
      required this.margin,
      required this.borderRadius,
      required this.presenter});

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
              aspectRatio: 1.7,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('lib/ui/assets/logo.jpg'),
              ),
            ),
            LoginFormFields(
              constraints: constraints,
              presenter: presenter,
            )
          ],
        ),
      ),
    );
  }
}
