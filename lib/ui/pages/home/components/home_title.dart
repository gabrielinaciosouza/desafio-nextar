import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../home.dart';
import 'filter_dialog.dart';

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<HomePresenter>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveHeadline1(text: R.strings.explore, color: Colors.white),
        IconButton(
          onPressed: () => filterDialog(context: context, presenter: presenter),
          icon: Icon(
            Icons.filter_alt,
            size: 40,
          ),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
