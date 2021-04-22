import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../../../infra/cache/secure_local_storage_adapter.dart';

SecureLocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();
  final localStorage = LocalStorage('desafio_nextar');
  return SecureLocalStorageAdapter(
      secureStorage: secureStorage, localStorage: localStorage);
}
