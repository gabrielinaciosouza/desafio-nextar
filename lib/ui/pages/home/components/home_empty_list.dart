import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

class HomeEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveHeadline6(
              color: Theme.of(context).accentColor,
              text: R.strings.clickToAddProduct,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
