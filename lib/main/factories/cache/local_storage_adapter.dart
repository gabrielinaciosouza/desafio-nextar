import 'package:desafio_nextar/infra/cache/cache.dart';
import 'package:localstorage/localstorage.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = LocalStorage('accounts');
  return LocalStorageAdapter(storage: secureStorage);
}
