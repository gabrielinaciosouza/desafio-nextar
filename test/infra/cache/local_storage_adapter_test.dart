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
}

void main() {
  late LocalStorageSpy storage;
  late LocalStorageAdapter sut;
  late String key;
  late String value;

  PostExpectation secureStorageReadCall() => when(storage.getItem(key));

  void mockFetchedValue() {
    secureStorageReadCall().thenAnswer((_) async => value);
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
  });
}
