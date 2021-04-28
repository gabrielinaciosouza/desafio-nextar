import '../helpers.dart';

enum UIError {
  unexpected,
  invalidCredentials,
  requiredField,
  invalidField,
  none,
  numericOnly,
  duplicatedCode
}

extension UIErrorEtension on UIError {
  String? get description {
    switch (this) {
      case UIError.invalidCredentials:
        return R.strings.invalidCredentials;
      case UIError.requiredField:
        return R.strings.requiredField;
      case UIError.invalidField:
        return R.strings.invalidField;
      case UIError.numericOnly:
        return R.strings.invalidField;
      case UIError.duplicatedCode:
        return R.strings.duplicatedCode;
      case UIError.none:
        return null;
      default:
        return R.strings.unexpected;
    }
  }
}
