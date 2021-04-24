import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../pages/pages.dart';

class ProductInput extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool validate;

  ProductInput(
      {required this.labelText,
      required this.icon,
      this.keyboardType = TextInputType.text,
      this.validate = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);
    return TextFormField(
      keyboardType: keyboardType,
      style: theme.textTheme.bodyText2!.apply(color: theme.primaryColorLight),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: theme.textTheme.bodyText2!.apply(color: theme.accentColor),
        icon: Icon(
          icon,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      onChanged: presenter.validateField,
    );
  }
}
