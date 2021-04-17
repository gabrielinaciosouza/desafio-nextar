import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(
    this.field,
  );

  ValidationError? validate(String? value) {
    return ValidationError.none;
  }
}

void main() {
  test('Should return ValidationError.none if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate('');
    expect(error, ValidationError.none);
  });
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate(null);
    expect(error, ValidationError.none);
  });
}
