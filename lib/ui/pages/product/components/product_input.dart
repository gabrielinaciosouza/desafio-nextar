import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../../../pages/pages.dart';

class ProductInput extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool validate;
  final Stream<UIError?>? stream;

  ProductInput(
      {required this.labelText,
      required this.icon,
      this.keyboardType = TextInputType.text,
      this.validate = false,
      this.stream});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);
    return Builder(
      builder: (contextt) {
        if (stream != null) {
          return StreamBuilder<UIError?>(
            stream: stream,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: keyboardType,
                style: theme.textTheme.bodyText2!
                    .apply(color: theme.primaryColorLight),
                decoration: InputDecoration(
                  labelText: labelText,
                  errorText:
                      snapshot.hasData ? snapshot.data!.description : null,
                  labelStyle: theme.textTheme.bodyText2!
                      .apply(color: theme.accentColor),
                  icon: Icon(
                    icon,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onChanged: validate ? presenter.validateField : null,
              );
            },
          );
        }
        return TextFormField(
          keyboardType: keyboardType,
          style:
              theme.textTheme.bodyText2!.apply(color: theme.primaryColorLight),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle:
                theme.textTheme.bodyText2!.apply(color: theme.accentColor),
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          onChanged: validate ? presenter.validateField : null,
        );
      },
    );
  }
}
