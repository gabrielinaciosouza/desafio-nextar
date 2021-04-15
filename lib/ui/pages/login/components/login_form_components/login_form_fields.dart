import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/helpers.dart';

import '../components.dart';
import '../../../pages.dart';
import '../../../../../ui/components/components.dart';

class LoginFormFields extends StatelessWidget {
  final LoginPresenter presenter;
  final BoxConstraints constraints;

  const LoginFormFields({
    required this.presenter,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<LoginPresenter>(
      create: (_) => presenter,
      lazy: false,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constraints.maxWidth > 950
                ? ResponsiveHeadline6(
                    text: R.strings.login,
                    color: Theme.of(context).primaryColorDark)
                : Container(),
            EmailInput(),
            Padding(
              padding: EdgeInsets.only(
                  top: constraints.maxHeight > 800
                      ? 800 * .006
                      : constraints.maxHeight * .006,
                  bottom: constraints.maxHeight > 800
                      ? 800 * .03
                      : constraints.maxHeight * .03),
              child: PasswordInput(),
            ),
            ResponsiveHeadline6(
                text: R.strings.forgotPassword,
                color: Theme.of(context).primaryColor),
            SizedBox(
              height: constraints.maxHeight > 800
                  ? 800 * .07
                  : constraints.maxHeight * .07,
            ),
            LoginButton(),
            SizedBox(
              height: constraints.maxHeight > 800
                  ? 800 * .025
                  : constraints.maxHeight * .025,
            ),
            Center(
              child: ResponsiveHeadline6(
                  text: R.strings.addAccount,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: constraints.maxHeight > 800
                  ? 800 * .03
                  : constraints.maxHeight * .03,
            ),
          ],
        ),
      ),
    );
  }
}
