import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../../pages.dart';

class ProductCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);

    if (presenter.product != null) {
      _controller.text = presenter.product!.code;
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }

    return Builder(builder: (contextt) {
      return StreamBuilder<UIError?>(
        stream: presenter.codeErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: presenter.product != null ? _controller : null,
            style: theme.textTheme.bodyText2!
                .apply(color: theme.primaryColorLight),
            decoration: InputDecoration(
              labelText: 'Código',
              errorText: snapshot.hasData ? snapshot.data!.description : null,
              labelStyle:
                  theme.textTheme.bodyText2!.apply(color: theme.accentColor),
              icon: Icon(
                Icons.code,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            onChanged: presenter.validateCode,
          );
        },
      );
    });
  }
}
