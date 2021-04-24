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
  var _nameError = Rx<UIError>(UIError.none);
  Stream<UIError?>? get nameErrorStream => _nameError.stream;

  void validateFields(String value) {
    _name = value;
    _nameError.value =
        validateField(field: 'any_field', value: value, validation: validation);
    _validateForm();
  }

  _validateForm() {
    isFormValid = _nameError.value == UIError.none;
  }
}

void main() {
  late GetxProductPresenter sut;
  late ValidationSpy validation;
  late String value;
  late String field;

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
    field = 'any_field';
  });
  test('Should call Validation with correct value value', () {
    sut.validateFields(value);
    verify(validation.validate(field: field, value: value)).called(1);
  });

  test(
      'Should emit name error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: field, value: value, error: ValidationError.invalidField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateFields(value);
    sut.validateFields(value);
  });

  test(
      'Should emit name error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: field, value: value, error: ValidationError.requiredField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateFields(value);
    sut.validateFields(value);
  });
}
