import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Validation {
  ValidationError validate({required String? field, required String? value});
}

class GetxLoginPresenter extends GetxController {
  final Validation validation;

  String? _email;
  String? _password;

  var _emailError = Rx<UIError>(UIError.none);
  var _passwordError = Rx<UIError>(UIError.none);
  var _isFormValid = false.obs;

  Stream<UIError?>? get emailErrorStream => _emailError.stream;
  Stream<UIError?>? get passwordErrorStream => _emailError.stream;
  Stream<bool?>? get isFormValidStream => _isFormValid.stream;

  GetxLoginPresenter({required this.validation});
  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
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
    print(error.toString());
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
}

enum ValidationError { requiredField, invalidField, none }

class ValidationSpy extends Mock implements Validation {
  @override
  ValidationError validate({required String? field, required String? value}) =>
      this.noSuchMethod(Invocation.method(#validate, [field, value]),
          returnValue: ValidationError.none,
          returnValueForMissingStub: ValidationError.none);
}

void main() {
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late String email;
  late String password;

  void mockValidation({
    required String value,
    required String field,
    required error,
  }) {
    when(validation.validate(field: field, value: value)).thenReturn(error);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = GetxLoginPresenter(validation: validation);
    email = 'any_email@mail.com';
    password = 'any_password';
  });
  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test(
      'Should emit email error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'email', value: email, error: ValidationError.invalidField);

    sut.emailErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test(
      'Should emit email error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'email', value: email, error: ValidationError.requiredField);

    sut.emailErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit empty if validation succeeds', () {
    sut.emailErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });
}
