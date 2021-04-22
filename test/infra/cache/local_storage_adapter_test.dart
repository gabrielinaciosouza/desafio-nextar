import 'package:desafio_nextar/infra/cache/cache.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements LocalStorage {
  final String fetchedValue;
  LocalStorageSpy({required this.fetchedValue});
  @override
  dynamic getItem(String key) =>
      this.noSuchMethod(Invocation.method(#getItem, [key]),
          returnValue: Future.value(fetchedValue),
          returnValueForMissingStub: Future.value(fetchedValue));

  @override
  Future<void> setItem(
    String key,
    value, [
    Object toEncodable(Object nonEncodable)?,
  ]) =>
      this.noSuchMethod(Invocation.method(#setItem, [key, value]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late LocalStorageSpy storage;
  late LocalStorageAdapter sut;
  late String key;
  late String value;

  PostExpectation localStorageGetItemCall() => when(storage.getItem(key));

  void throwFetchError() {
    localStorageGetItemCall().thenThrow(Exception());
  }

  void mockFetchedValue() {
    localStorageGetItemCall().thenAnswer((_) async => value);
  }

  setUp(() {
    key = 'any_key';
    value = 'any_value';
    storage = LocalStorageSpy(fetchedValue: value);
    sut = LocalStorageAdapter(storage: storage);
    mockFetchedValue();
  });

  group('fetch', () {
    test('Should call fetch with correct value', () async {
      await sut.fetch(key);

      verify(storage.getItem(key));
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetch(key);

      expect(fetchedValue, value);
    });

    test('Should throw if Fetch throws', () async {
      throwFetchError();

      final future = sut.fetch(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('save', () {
    test('Should call save with correct values', () async {
      await sut.save(key: key, value: value);

      verify(storage.setItem(key, value));
    });
  });
}
