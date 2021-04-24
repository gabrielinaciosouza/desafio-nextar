import '../../cache/cache.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSecureLogoff implements DeleteFromCache {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  LocalSecureLogoff({required this.deleteSecureCacheStorage});

  @override
  Future<void> delete(String code) async {
    try {
      return await deleteSecureCacheStorage.deleteSecure(key: code);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
