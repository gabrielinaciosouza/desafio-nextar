import 'package:localstorage/localstorage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter implements FetchCacheStorage {
  final LocalStorage storage;

  LocalStorageAdapter({required this.storage});
  @override
  Future<dynamic> fetch(String key) {
    return storage.getItem(key);
  }
}
