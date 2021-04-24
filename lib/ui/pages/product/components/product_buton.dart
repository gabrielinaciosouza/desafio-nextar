import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

class ProductButton extends StatelessWidget {
  final CheckPlatform runningPlatform = CheckPlatform.check();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height > 800 ? 60 : 50,
      width: double.infinity,
      child: runningPlatform.currentPlatform == CurrentPlatform.isIOS
          ? CupertinoButton(
              disabledColor: Theme.of(context).primaryColor.withAlpha(150),
              color: Theme.of(context).primaryColor,
              child: ResponsiveHeadline6(
                color: Theme.of(context).primaryColorLight,
                text: R.strings.enter,
              ),
              onPressed: () {})
          : ElevatedButton(
              onPressed: () {},
              child: ResponsiveHeadline6(
                color: Theme.of(context).primaryColorLight,
                text: R.strings.save,
              ),
            ),
    );
  }
}
