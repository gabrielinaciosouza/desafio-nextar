import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../../pages.dart';

class ProductButton extends StatelessWidget {
  final CheckPlatform runningPlatform = CheckPlatform.check();

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ProductPresenter>(context);
    return StreamBuilder<bool?>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height > 800 ? 60 : 50,
            width: double.infinity,
            child: runningPlatform.currentPlatform == CurrentPlatform.isIOS
                ? CupertinoButton(
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(150),
                    color: Theme.of(context).primaryColor,
                    child: ResponsiveHeadline6(
                      color: Theme.of(context).primaryColorLight,
                      text: R.strings.enter,
                    ),
                    onPressed: snapshot.data == true
                        ? () async => presenter.submit()
                        : null)
                : ElevatedButton(
                    onPressed: snapshot.data == true
                        ? () async => presenter.submit()
                        : null,
                    child: ResponsiveHeadline6(
                      color: Theme.of(context).primaryColorLight,
                      text: R.strings.save,
                    ),
                  ),
          );
        });
  }
}
