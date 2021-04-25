import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

DeleteFromCache makeLocalDeleteProduct() {
  return LocalDeleteProduct(
      deleteCacheStorage: makeLocalStorageAdapter(),
      fetchCacheStorage: makeLocalStorageAdapter(),
      saveCacheStorage: makeLocalStorageAdapter());
}
