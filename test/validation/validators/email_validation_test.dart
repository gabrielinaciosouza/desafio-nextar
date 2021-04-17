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
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return ValidationError.none if email is empty', () {
    expect(sut.validate(''), ValidationError.none);
  });
  test('Should return null if email is empty', () {
    expect(sut.validate(null), ValidationError.none);
  });

  test('Should return ValidationError.none if email is valid', () {
    expect(sut.validate('gabriel@gabriel.com'), ValidationError.none);
  });
}
