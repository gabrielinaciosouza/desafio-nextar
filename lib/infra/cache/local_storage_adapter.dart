import 'package:localstorage/localstorage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter implements FetchCacheStorage, SaveCacheStorage {
  final LocalStorage storage;

  LocalStorageAdapter({required this.storage});
  @override
  Future<dynamic> fetch(String key) async {
    return await storage.getItem(key);
  }

  @override
  Future<void> save({required String key, required String value}) {
    throw UnimplementedError();
  }
}
