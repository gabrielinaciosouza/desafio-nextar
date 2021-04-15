import 'package:desafio_nextar/ui/helpers/helpers.dart';

abstract class LoginPresenter {
  Stream<UIError?>? get emailErrorStream;
  Stream<UIError?>? get passwordErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
}
