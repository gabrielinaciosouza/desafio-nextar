import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages.dart';

class ProductStockInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);

    return StreamBuilder<String?>(
        stream: presenter.stockStream,
        builder: (context, snapshot) {
          _controller.text = snapshot.data ?? '';
          _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length));
          return TextFormField(
            controller: _controller,
            onChanged: (value) => presenter.stock = value,
            style: theme.textTheme.bodyText2!
                .apply(color: theme.primaryColorLight),
            decoration: InputDecoration(
              labelText: 'Estoque',
              labelStyle:
                  theme.textTheme.bodyText2!.apply(color: theme.accentColor),
              icon: Icon(
                Icons.attach_money,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          );
        });
  }
}
