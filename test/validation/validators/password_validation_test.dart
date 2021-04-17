import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:desafio_nextar/validation/validators/validators.dart';
import 'package:test/test.dart';

class PasswordValidation implements FieldValidation {
  final String field;
  PasswordValidation(
    this.field,
  );

  ValidationError? validate(String? value) {
    if (value!.isEmpty) {
      return ValidationError.requiredField;
    }

    final isValid = value.length >= 6;
    return isValid ? ValidationError.none : ValidationError.invalidField;
  }
}

void main() {
  late PasswordValidation sut;

  setUp(() {
    sut = PasswordValidation('any_field');
  });
  test('Should return ValidationError.none if password is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return ValidationError.none if password is valid', () {
    expect(sut.validate('123456'), ValidationError.none);
  });
}
