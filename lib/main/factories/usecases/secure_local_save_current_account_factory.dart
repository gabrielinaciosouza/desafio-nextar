import 'package:loja_virtual/data/usecases/usecases.dart';

import '../factories.dart';

SecureLocalSaveCurrentAccount makeSecureLocalSaveCurrentAccount() {
  return SecureLocalSaveCurrentAccount(
      saveSecureCacheStorage: makeSecureLocalStorageAdapter());
}
