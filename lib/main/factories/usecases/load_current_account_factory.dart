import '../../../data/usecases/load_current_account/load_current_account.dart';

import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return SecureLocalLoadCurrentAccount(
      fetchSecureCacheStorage: makeLocalStorageAdapter());
}
