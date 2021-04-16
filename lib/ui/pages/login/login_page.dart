import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../pages/login/login.dart';
import 'components/spinner_dialog.dart';
import 'platform_screens/platform_screens.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        void _hideKeyboard() {
          final currectFocus = FocusScope.of(context);
          if (!currectFocus.hasPrimaryFocus) {
            currectFocus.unfocus();
          }
        }

        presenter.isLoadingStream!.listen(
          (isLoading) {
            if (isLoading == true) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          },
        );
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
