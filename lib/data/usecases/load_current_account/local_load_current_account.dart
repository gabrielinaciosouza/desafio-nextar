import '../../../domain/helpers/helpers.dart';

import '../../../domain/entities/entities.dart';

import '../../cache/cache.dart';

import '../../../domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token!);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
