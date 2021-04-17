import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  ValidationError? validate(String? value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  ValidationError? validate(String? value) {
    return ValidationError.none;
  }
}

void main() {
  test('Should return ValidationError.none if value is not empty', () {
    final sut = RequiredFieldValidation('any_field');

    final error = sut.validate('any_value');

    expect(error, ValidationError.none);
  });
}
