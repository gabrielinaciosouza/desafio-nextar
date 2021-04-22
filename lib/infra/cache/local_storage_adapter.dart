import '../../data/cache/cache.dart';

class LocalStorageAdapter implements FetchCacheStorage {
  @override
  Future fetch(String key) {
    throw UnimplementedError();
  }
}
