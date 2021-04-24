import 'package:flutter/material.dart';

class ProductInput extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;

  ProductInput(
      {required this.labelText,
      required this.icon,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
    );
  }
}
