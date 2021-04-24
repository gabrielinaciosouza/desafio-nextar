import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class HomeErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<HomePresenter>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveHeadline6(
            color: Theme.of(context).accentColor,
            text: R.strings.unexpected,
          ),
          ElevatedButton(
            onPressed: presenter.loadProducts,
            child: Text(
              R.strings.reload,
            ),
          ),
        ],
      ),
    );
  }
}
