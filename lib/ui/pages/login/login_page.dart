import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../pages/login/login.dart';
import 'platform_screens/platform_screens.dart';
import '../../mixins/mixins.dart';

class LoginPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager {
  final LoginPresenter presenter;
  LoginPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        handleMainError(context, presenter.mainErrorStream);
        return GestureDetector(
          onTap: () => hideKeyboard(context),
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
