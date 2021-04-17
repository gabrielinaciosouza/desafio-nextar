import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/presentation/presenters/getx_login_presenter.dart';
import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  @override
  Future<void> save(AccountEntity account) =>
      super.noSuchMethod(Invocation.method(#save, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;
  late String token;
  late SaveCurrentAccountSpy saveCurrentAccount;

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

  void mockSaveCurrentAccountError() {
    when(saveCurrentAccount.save(AccountEntity(token: token)))
        .thenThrow(DomainError.unexpected);
  }

  setUp(() {
    saveCurrentAccount = SaveCurrentAccountSpy();
    token = 'any_token';
    validation = ValidationSpy();
    authentication = AuthenticationSpy(response: AccountEntity(token: token));
    sut = GetxLoginPresenter(
        validation: validation,
        authentication: authentication,
        saveCurrentAccount: saveCurrentAccount);
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
    expectLater(sut.mainErrorStream,
        emitsInOrder([UIError.none, UIError.invalidCredentials]));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(error: DomainError.unexpected);

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
        sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

    await sut.auth();
  });

  test('Should call SaveCurrentAccount with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(saveCurrentAccount.save(AccountEntity(token: token))).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockSaveCurrentAccountError();

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
        sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

    await sut.auth();
  });
}
