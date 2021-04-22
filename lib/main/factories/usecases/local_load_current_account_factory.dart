import '../../../data/usecases/load_current_account/load_current_account.dart';

import '../factories.dart';

LocalLoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(fetchCacheStorage: makeLocalStorageAdapter());
}
