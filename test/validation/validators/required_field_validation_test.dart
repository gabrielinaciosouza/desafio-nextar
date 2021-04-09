import 'package:loja_virtual/presentation/protocols/protocols.dart';
import 'package:loja_virtual/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return ValidationError.none if value is not empty', () {
    expect(sut.validate('any_value'), ValidationError.none);
  });

  test('Should return ValidationError.requiredField if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return ValidationError.requiredField if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
