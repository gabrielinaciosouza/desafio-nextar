import 'package:localstorage/localstorage.dart';

import '../../../infra/cache/cache.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = LocalStorage('accounts');
  return LocalStorageAdapter(storage: secureStorage);
}
