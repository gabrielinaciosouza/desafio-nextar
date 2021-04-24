import 'package:desafio_nextar/main/builders/builders.dart';

import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeProductValidation() {
  return ValidationComposite(makeProductValidations());
}

List<FieldValidation> makeProductValidations() {
  return [
    ...ValidationBuilder.field('code').requiredField().build(),
    ...ValidationBuilder.field('name').requiredField().build()
  ];
}
