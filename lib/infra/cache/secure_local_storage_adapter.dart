import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/cache/cache.dart';

class SecureLocalStorageAdapter
    implements
        SaveSecureCacheStorage,
        FetchSecureCacheStorage,
        DeleteSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  SecureLocalStorageAdapter({required this.secureStorage});

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> fetchSecure(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> deleteSecure({required String key}) async {
    await secureStorage.delete(key: key);
  }
}
