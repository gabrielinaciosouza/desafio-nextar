import '../../utils/platform/platform.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter
    implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  final LocalStorage localStorage;

  LocalStorageAdapter(
      {required this.secureStorage, required this.localStorage});

  late CheckPlatform _runningPlatform;

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    _check();
    if (_runningPlatform.currentPlatform != CurrentPlatform.isWeb) {
      await secureStorage.write(key: key, value: value);
    } else {
      await localStorage.setItem(key, value);
    }
  }

  @override
  Future<String?> fetchSecure(String key) async {
    _check();
    if (_runningPlatform.currentPlatform != CurrentPlatform.isWeb) {
      return await secureStorage.read(key: key);
    } else {
      final value = await localStorage.getItem(key);
      return value;
    }
  }

  void _check() {
    _runningPlatform = CheckPlatform.check();
  }
}
