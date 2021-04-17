import 'package:desafio_nextar/infra/cache/cache.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  final String fetchedValue;
  FlutterSecureStorageSpy({required this.fetchedValue});
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
  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions = IOSOptions.defaultOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
  }) =>
      this.noSuchMethod(Invocation.method(#write, []),
          returnValue: Future.value(fetchedValue),
          returnValueForMissingStub: Future.value(fetchedValue));
}

void main() {
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;
  late String key;
  late String value;

  PostExpectation secureStorageWriteCall() =>
      when(secureStorage.write(key: key, value: value));

  PostExpectation secureStorageReadCall() => when(secureStorage.read(key: key));

  void throwSaveError() {
    secureStorageWriteCall().thenThrow(Exception());
  }

  void throwFetchError() {
    secureStorageReadCall().thenThrow(Exception());
  }

  void mockFetchedValue() {
    secureStorageReadCall().thenAnswer((_) async => value);
  }

  setUp(() {
    key = 'any_key';
    value = 'any_value';
    secureStorage = FlutterSecureStorageSpy(fetchedValue: value);
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    mockFetchedValue();
  });

  group('saveSecure', () {
    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });

    test('Should throw if SaveSecure throws', () async {
      throwSaveError();

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });

    test('Should throw if FetchSecure throws', () async {
      throwFetchError();

      final future = sut.fetchSecure(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });
}
