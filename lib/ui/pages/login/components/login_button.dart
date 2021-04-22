import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../helpers/helpers.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CheckPlatform runningPlatform = CheckPlatform.check();

    final presenter = Provider.of<LoginPresenter>(context);

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
                        ? () async => presenter.auth()
                        : null)
                : ElevatedButton(
                    onPressed: snapshot.data == true
                        ? () async => presenter.auth()
                        : null,
                    child: ResponsiveHeadline6(
                      color: Theme.of(context).primaryColorLight,
                      text: R.strings.enter,
                    ),
                  ),
          );
        });
  }
}
