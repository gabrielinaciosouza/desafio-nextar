import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:desafio_nextar/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({required this.secureStorage});

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }
}

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions = IOSOptions.defaultOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
  }) =>
      this.noSuchMethod(Invocation.method(#write, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  test('Should call save secure with correct values', () async {
    final secureStorage = FlutterSecureStorageSpy();
    final sut = LocalStorageAdapter(secureStorage: secureStorage);
    final key = 'any_key';
    final value = 'any_value';

    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });
}
