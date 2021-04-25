import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages.dart';

class ProductPriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);
    if (presenter.product != null) {
      _controller.text = presenter.product!.price.toString();
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    return TextFormField(
      controller: presenter.product != null ? _controller : null,
      onChanged: (value) => presenter.price = value,
      style: theme.textTheme.bodyText2!.apply(color: theme.primaryColorLight),
      decoration: InputDecoration(
        labelText: 'Preço',
        labelStyle: theme.textTheme.bodyText2!.apply(color: theme.accentColor),
        icon: Icon(
          Icons.archive,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
