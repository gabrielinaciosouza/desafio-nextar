import '../../../domain/usecases/load_current_account.dart';

import '../../../data/usecases/load_current_account/load_current_account.dart';

import '../factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(fetchCacheStorage: makeLocalStorageAdapter());
}
