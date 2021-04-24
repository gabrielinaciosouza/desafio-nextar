import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

SaveProduct makeLocalSaveProduct() {
  return LocalSaveProduct(saveCacheStorage: makeLocalStorageAdapter());
}
