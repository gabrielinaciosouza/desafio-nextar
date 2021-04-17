import 'package:desafio_nextar/presentation/protocols/protocols.dart';

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
