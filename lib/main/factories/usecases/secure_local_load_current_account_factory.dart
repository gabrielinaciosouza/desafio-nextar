import '../../../data/usecases/load_current_account/load_current_account.dart';

import '../factories.dart';

SecureLocalLoadCurrentAccount makeSecureLocalLoadCurrentAccount() {
  return SecureLocalLoadCurrentAccount(
      fetchSecureCacheStorage: makeSecureLocalStorageAdapter());
}
