import 'package:test/test.dart';

import 'package:loja_virtual/presentation/protocols/protocols.dart';
import 'package:loja_virtual/validation/validators/validators.dart';

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

  test('Should return error if password is invalid', () {
    expect(sut.validate('12345'), ValidationError.invalidField);
  });
}
