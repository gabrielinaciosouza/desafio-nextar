import 'package:localstorage/localstorage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter implements FetchCacheStorage {
  final LocalStorage storage;

  LocalStorageAdapter({required this.storage});
  @override
  Future<dynamic> fetch(String key) async {
    return await storage.getItem(key);
  }
}
