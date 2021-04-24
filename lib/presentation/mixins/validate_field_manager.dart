import 'package:desafio_nextar/presentation/protocols/protocols.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:get/get.dart';

mixin ValidateFieldManager on GetxController {
  UIError validateField(
      {String? field, String? value, required Validation validation}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.none:
        return UIError.none;
      default:
        return UIError.none;
    }
  }
}
