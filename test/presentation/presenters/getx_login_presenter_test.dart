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
  late GetxLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  setUp(() {
    validation = ValidationSpy();
    sut = GetxLoginPresenter(validation: validation);
    email = 'any_email@mail.com';
  });
  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
