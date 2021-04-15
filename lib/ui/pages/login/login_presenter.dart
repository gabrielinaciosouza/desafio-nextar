import 'package:desafio_nextar/ui/helpers/helpers.dart';

abstract class LoginPresenter {
  Stream<UIError?>? get emailErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
}
