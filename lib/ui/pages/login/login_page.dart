import 'package:desafio_nextar/ui/pages/login/login.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'platform_screens/platform_screens.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currectFocus = FocusScope.of(context);
      if (!currectFocus.hasPrimaryFocus) {
        currectFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: _hideKeyboard,
          child: BaseWidget(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceType == DeviceScreenType.MOBILE) {
                return MobileLoginScreen(presenter: presenter);
              }
              if (sizingInformation.deviceType == DeviceScreenType.TABLET) {
                return TabletLoginScreen(presenter: presenter);
              }
              return DesktopLoginScreen(presenter: presenter);
            },
          ),
        );
      }),
    );
  }
}
