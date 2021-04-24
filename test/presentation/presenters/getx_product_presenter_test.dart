import 'package:desafio_nextar/presentation/mixins/mixins.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/presentation/protocols/protocols.dart';

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

class GetxProductPresenter extends GetxController
    with FormManager, ValidateFieldManager {
  final Validation validation;

  GetxProductPresenter({required this.validation});

  String? _name;
  String? _code;

  var _nameError = Rx<UIError>(UIError.none);
  var _codeError = Rx<UIError>(UIError.none);

  Stream<UIError?>? get nameErrorStream => _nameError.stream;
  Stream<UIError?>? get codeErrorStream => _codeError.stream;

  void validateName(String value) {
    _name = value;
    _nameError.value =
        validateField(field: 'name', value: value, validation: validation);
    _validateForm();
  }

  void validateCode(String value) {
    _code = value;
    _codeError.value =
        validateField(field: 'code', value: value, validation: validation);
    _validateForm();
  }

  _validateForm() {
    isFormValid = _nameError.value == UIError.none &&
        _codeError.value == UIError.none &&
        _name != null &&
        _code != null;
  }
}

void main() {
  late GetxProductPresenter sut;
  late ValidationSpy validation;
  late String value;

  void mockValidation({
    required String value,
    required String field,
    required error,
  }) {
    when(validation.validate(field: field, value: value)).thenReturn(error);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = GetxProductPresenter(validation: validation);
    value = 'any_value';
  });
  test('Should call Validation with correct value value', () {
    sut.validateName(value);
    verify(validation.validate(field: 'name', value: value)).called(1);
  });

  test(
      'Should emit name error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.invalidField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test(
      'Should emit name error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.requiredField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test(
      'Should emit code error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.invalidField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test(
      'Should emit code error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.requiredField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });
}
