import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:desafio_nextar/validation/validators/validators.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FieldValidationSpy extends Mock implements FieldValidation {
  @override
  ValidationError? validate(String? value) =>
      super.noSuchMethod(Invocation.method(#validate, ['any_error']));

  @override
  String get field => super.noSuchMethod(Invocation.getter(#field),
      returnValue: 'any_field', returnValueForMissingStub: 'any_field');
}

void main() {
  late ValidationComposite sut;
  late FieldValidation validation1;
  late FieldValidation validation2;
  late FieldValidation validation3;

  void mockValidation1(ValidationError? error) {
    when(validation1.validate('any_value')).thenReturn(error);
  }

  void mockValidation2(ValidationError? error) {
    when(validation2.validate('any_value')).thenReturn(error);
  }

  void mockValidation3(ValidationError? error) {
    when(validation3.validate('any_value')).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);

    sut = ValidationComposite([validation1, validation2, validation3]);
  });
  test('Should return ValidationError.none if all validations returns null',
      () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, ValidationError.none);
  });

  test('Should return the first error of the field', () {
    mockValidation1(ValidationError.none);
    mockValidation2(ValidationError.invalidField);
    mockValidation3(ValidationError.requiredField);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, ValidationError.requiredField);
  });
}
