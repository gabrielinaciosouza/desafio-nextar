import '../../cache/cache.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalDeleteProduct implements DeleteFromCache {
  final DeleteCacheStorage deleteCacheStorage;
  LocalDeleteProduct({required this.deleteCacheStorage});

  @override
  Future<void> delete(String code) async {
    try {
      return await deleteCacheStorage.delete(key: code);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
