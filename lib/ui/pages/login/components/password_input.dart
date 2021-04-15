import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../login.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return TextFormField(
      onChanged: presenter.validatePassword,
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
