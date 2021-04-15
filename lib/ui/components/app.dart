import 'package:desafio_nextar/ui/components/app_theme.dart';
import 'package:desafio_nextar/ui/helpers/errors/ui_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Desafio Nextar',
      theme: makeAppTheme(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(LoginPresenterFake()),
    );
  }
}

class LoginPresenterFake implements LoginPresenter {
  //just for compile
  @override
  void validateEmail(String email) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }

  @override
  // TODO: implement emailErrorStream
  Stream<UIError?>? get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<UIError?>? get passwordErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool?>? get isFormValidStream => throw UnimplementedError();

  @override
  Future<void> auth() {
    // TODO: implement auth
    throw UnimplementedError();
  }
}
