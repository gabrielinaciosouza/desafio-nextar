import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

LoadProduct makeLocalLoadProduct() {
  return LocalLoadProduct(fetchCacheStorage: makeLocalStorageAdapter());
}
