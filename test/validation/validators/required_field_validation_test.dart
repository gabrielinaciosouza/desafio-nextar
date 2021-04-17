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
    return value?.isNotEmpty == true
        ? ValidationError.none
        : ValidationError.requiredField;
  }
}

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
