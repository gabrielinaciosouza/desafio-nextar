import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Validation {
  ValidationError validate({required String field, required String value});
}

class GetxLoginPresenter {
  final Validation validation;

  GetxLoginPresenter({required this.validation});
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
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
  test('Should call Validation with correct email', () {
    final validation = ValidationSpy();
    final sut = GetxLoginPresenter(validation: validation);
    final email = 'any_email@mail.com';
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
