import 'package:desafio_nextar/data/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

LoadProducts makeLocalLoadProducts() {
  return LocalLoadProducts(fetchCacheStorage: makeLocalStorageAdapter());
}
