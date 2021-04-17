import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(
    this.field,
  );

  ValidationError? validate(String? value) {
    if (value!.isEmpty) {
      return ValidationError.requiredField;
    }
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? ValidationError.none : ValidationError.invalidField;
  }
}

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return ValidationError.none if email is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return ValidationError.none if email is valid', () {
    expect(sut.validate('gabriel@gabriel.com'), ValidationError.none);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('gabriel@gabriel'), ValidationError.invalidField);
  });
}
