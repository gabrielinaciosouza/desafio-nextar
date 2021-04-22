import 'package:desafio_nextar/data/usecases/usecases.dart';

import '../factories.dart';

SecureLocalSaveCurrentAccount makeSecureLocalSaveCurrentAccount() {
  return SecureLocalSaveCurrentAccount(
      saveSecureCacheStorage: makeSecureLocalStorageAdapter());
}
