import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveHeadline1(text: R.strings.explore, color: Colors.white),
        Icon(
          Icons.filter_alt,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      ],
    );
  }
}
