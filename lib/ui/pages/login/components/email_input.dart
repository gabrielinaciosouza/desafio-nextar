import 'package:flutter/material.dart';
import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
