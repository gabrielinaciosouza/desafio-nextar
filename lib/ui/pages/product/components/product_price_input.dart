import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages.dart';

class ProductPriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = MoneyMaskedTextController(
      leftSymbol: 'R\$',
    );

    final theme = Theme.of(context);
    final presenter = Provider.of<ProductPresenter>(context);

    return StreamBuilder<String?>(
        stream: presenter.priceStream,
        builder: (context, snapshot) {
          _controller.text = snapshot.data ?? '';
          _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length));
          return TextFormField(
            controller: _controller,
            onChanged: (value) => presenter.price = value,
            style: theme.textTheme.bodyText2!
                .apply(color: theme.primaryColorLight),
            decoration: InputDecoration(
              labelText: 'Preço',
              labelStyle:
                  theme.textTheme.bodyText2!.apply(color: theme.accentColor),
              icon: Icon(
                Icons.archive,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          );
        });
  }
}
