import '../helpers.dart';

enum UIError {
  unexpected,
  invalidCredentials,
  requiredField,
  invalidField,
  none
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
      case UIError.none:
        return null;
      default:
        return R.strings.unexpected;
    }
  }
}
