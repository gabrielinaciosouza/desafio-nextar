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

class GetxProductPresenter {
  final Validation validation;

  GetxProductPresenter({required this.validation});
  void validateField(String value) {
    validation.validate(field: 'any_field', value: value);
  }
}

void main() {
  late GetxProductPresenter sut;
  late ValidationSpy validation;
  late String value;

  setUp(() {
    validation = ValidationSpy();
    sut = GetxProductPresenter(validation: validation);
    value = 'any_value';
  });
  test('Should call Validation with correct value value', () {
    sut.validateField(value);
    verify(validation.validate(field: 'any_field', value: value)).called(1);
  });
}
