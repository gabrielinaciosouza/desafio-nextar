import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Validation {
  ValidationError validate({required String? field, required String? value});
}

class GetxLoginPresenter extends GetxController {
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

enum ValidationError { requiredField, invalidField, none }

class ValidationSpy extends Mock implements Validation {
  @override
  ValidationError validate({required String? field, required String? value}) =>
      this.noSuchMethod(Invocation.method(#validate, [field, value]),
          returnValue: ValidationError.none,
          returnValueForMissingStub: ValidationError.none);
}

class AuthenticationSpy extends Mock implements Authentication {
  final AccountEntity response;
  AuthenticationSpy({required this.response});
  @override
  Future<AccountEntity> auth(AuthenticationParams params) =>
      super.noSuchMethod(Invocation.method(#auth, [params]),
          returnValue: Future.value(response),
          returnValueForMissingStub: Future.value(response));
}

void main() {
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;
  late String token;

  void mockValidation({
    required String value,
    required String field,
    required error,
  }) {
    when(validation.validate(field: field, value: value)).thenReturn(error);
  }

  PostExpectation authenticationCall() => when(authentication
      .auth(AuthenticationParams(email: email, password: password)));
  void mockAuthenticationError({required DomainError error}) {
    authenticationCall().thenThrow(error);
  }

  setUp(() {
    token = 'any_token';
    validation = ValidationSpy();
    authentication = AuthenticationSpy(response: AccountEntity(token: token));
    sut = GetxLoginPresenter(
        validation: validation, authentication: authentication);
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

  test(
      'Should emit password error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'password',
        value: password,
        error: ValidationError.invalidField);

    sut.passwordErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test(
      'Should emit password error if validation returns ValidationError.requiredField',
      () {
    mockValidation(
        field: 'password',
        value: password,
        error: ValidationError.requiredField);

    sut.passwordErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit UIError.none if validation succeeds', () {
    sut.passwordErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit isFormValid false if email validavalidation fails', () {
    mockValidation(
        field: 'email', value: email, error: ValidationError.invalidField);

    sut.emailErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.passwordErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit isFormValid true if validations succeeds', () async {
    sut.emailErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.passwordErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, password: password)))
        .called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(true));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(error: DomainError.invalidCredentials);

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream!.listen(expectAsync1(
        (error) => expect(error!.description, 'Credenciais inválidas.')));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(error: DomainError.unexpected);

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream!.listen(expectAsync1((error) => expect(
        error!.description,
        'Algo errado aconteceu. Tente novamente em breve.')));

    await sut.auth();
  });
}
