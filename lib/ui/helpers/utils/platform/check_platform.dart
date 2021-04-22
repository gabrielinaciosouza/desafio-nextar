import 'dart:io' show Platform;

enum CurrentPlatform { isWeb, isIOS, isAndroid }

class CheckPlatform {
  static late CheckPlatform _instance;
  late CurrentPlatform currentPlatform;

  CheckPlatform._();

  static CheckPlatform check() {
    _instance = CheckPlatform._();

    try {
      if (Platform.isAndroid) {
        _instance.currentPlatform = CurrentPlatform.isAndroid;
      } else if (Platform.isIOS) {
        _instance.currentPlatform = CurrentPlatform.isIOS;
      } else {
        _instance.currentPlatform = CurrentPlatform.isAndroid;
      }
    } catch (e) {
      _instance.currentPlatform = CurrentPlatform.isWeb;
    }

    return _instance;
  }
}
