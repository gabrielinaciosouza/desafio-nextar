import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../../../infra/cache/local_storage_adapter.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  final localStorage = LocalStorage('desafio_nextar');
  return LocalStorageAdapter(
      secureStorage: secureStorage, localStorage: localStorage);
}
