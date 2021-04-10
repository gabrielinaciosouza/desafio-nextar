import 'dart:io' show Platform;

class RunningPlatform {
  late bool isIOS;
  late bool isAndroid;
  late bool isWeb;
  static late RunningPlatform _instance;

  RunningPlatform._();

  static RunningPlatform check() {
    _instance = RunningPlatform._();
    try {
      if (Platform.isAndroid) {
        _instance.isAndroid = true;
        _instance.isIOS = false;
        _instance.isWeb = false;
      } else if (Platform.isIOS) {
        _instance.isAndroid = false;
        _instance.isIOS = true;
        _instance.isWeb = false;
      } else {
        _instance.isAndroid = true;
        _instance.isIOS = false;
        _instance.isWeb = false;
      }
    } catch (e) {
      _instance.isAndroid = false;
      _instance.isIOS = false;
      _instance.isWeb = true;
    }

    return _instance;
  }
}
