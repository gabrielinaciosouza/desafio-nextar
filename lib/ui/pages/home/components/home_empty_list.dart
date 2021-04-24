import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../../../pages/pages.dart';

class HomeEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<HomePresenter>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          GestureDetector(
            onTap: presenter.logoff,
            child: Align(
              alignment: Alignment.topRight,
              child: ResponsiveHeadline6(
                color: Theme.of(context).accentColor,
                text: R.strings.logoff,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveHeadline6(
                  color: Theme.of(context).accentColor,
                  text: R.strings.clickToAddProduct,
                ),
                ElevatedButton(
                  onPressed: presenter.goToNewProduct,
                  child: Text(
                    R.strings.newProduct,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
