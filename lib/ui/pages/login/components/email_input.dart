import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../pages/pages.dart';
import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return TextFormField(
      onChanged: presenter.validateEmail,
      decoration: InputDecoration(
        labelText: R.strings.email,
        icon: Icon(
          Icons.email_outlined,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
