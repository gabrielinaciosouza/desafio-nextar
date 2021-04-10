import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.password,
        icon: Icon(
          Icons.lock_outline,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      obscureText: true,
    );
  }
}
