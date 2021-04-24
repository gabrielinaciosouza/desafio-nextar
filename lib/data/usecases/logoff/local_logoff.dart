import '../../cache/cache.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalLogoff implements DeleteFromCache {
  final DeleteCacheStorage deleteCacheStorage;

  LocalLogoff({required this.deleteCacheStorage});

  @override
  Future<void> delete(String key) async {
    try {
      await deleteCacheStorage.delete(key: key);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
