import 'package:desafio_nextar/ui/pages/login/login.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  GetxLoginPresenter({required this.validation, required this.authentication});

  String? _email;
  String? _password;

  var _emailError = Rx<UIError>(UIError.none);
  var _passwordError = Rx<UIError>(UIError.none);
  var _mainError = Rx<UIError>(UIError.none);
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<UIError?>? get emailErrorStream => _emailError.stream;
  Stream<UIError?>? get passwordErrorStream => _passwordError.stream;
  Stream<UIError?>? get mainErrorStream => _mainError.stream;
  Stream<bool?>? get isFormValidStream => _isFormValid.stream;
  Stream<bool?>? get isLoadingStream => _isLoading.stream;

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == UIError.none &&
        _passwordError.value == UIError.none &&
        _email != null &&
        _password != null;
  }

  UIError _validateField({String? field, String? value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.none:
        return UIError.none;
      default:
        return UIError.none;
    }
  }

  Future<void> auth() async {
    try {
      _mainError.value = UIError.none;
      _isLoading.value = true;
      await authentication
          .auth(AuthenticationParams(email: _email, password: _password));
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _mainError.value = UIError.invalidCredentials;
          break;
        default:
          _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }
}
