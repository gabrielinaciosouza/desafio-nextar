import '../../presentation/protocols/protocols.dart';

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
