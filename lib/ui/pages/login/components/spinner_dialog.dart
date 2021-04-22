import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

void showLoading(BuildContext context) {
  final CheckPlatform runningPlatform = CheckPlatform.check();

  runningPlatform.currentPlatform == CurrentPlatform.isIOS
      ? showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(child: CupertinoActivityIndicator());
          },
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
