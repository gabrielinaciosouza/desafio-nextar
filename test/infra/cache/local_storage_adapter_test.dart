import 'package:desafio_nextar/infra/cache/cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;
  late String key;
  late String value;

  PostExpectation secureStorageWriteCall() =>
      when(secureStorage.write(key: key, value: value));

  void throwSaveError() {
    secureStorageWriteCall().thenThrow(Exception());
  }

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = 'any_key';
    value = 'any_value';
  });

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if SaveSecure throws', () async {
    throwSaveError();

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
