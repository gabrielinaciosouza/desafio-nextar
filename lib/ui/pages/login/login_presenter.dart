import 'package:desafio_nextar/ui/helpers/helpers.dart';

abstract class LoginPresenter {
  Stream<UIError?>? get emailErrorStream;
  Stream<UIError?>? get passwordErrorStream;
  Stream<bool?>? get isFormValidStream;

  void validateEmail(String email);
  void validatePassword(String password);
}
