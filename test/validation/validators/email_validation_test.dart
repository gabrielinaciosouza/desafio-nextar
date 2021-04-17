import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:desafio_nextar/validation/validators/validators.dart';
import 'package:test/test.dart';

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
