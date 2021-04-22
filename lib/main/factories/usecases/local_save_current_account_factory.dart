import '../../../data/usecases/save_current_account/save_current_account.dart';

import '../factories.dart';

LocalSaveCurrentAccount makeLocalSaveCurrentAccount() {
  return LocalSaveCurrentAccount(
      saveSecureCacheStorage: makeLocalStorageAdapter());
}
