import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../../data/cache/cache.dart';

class SecureLocalStorageAdapter
    implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  final LocalStorage localStorage;

  SecureLocalStorageAdapter(
      {required this.secureStorage, required this.localStorage});

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> fetchSecure(String key) async {
    final value = await localStorage.getItem(key);
    return value;
  }
}
