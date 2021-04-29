import '../../presentation/protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  ValidationError? validate(String? value) {
    return value?.isNotEmpty == true
        ? ValidationError.none
        : ValidationError.requiredField;
  }
}
