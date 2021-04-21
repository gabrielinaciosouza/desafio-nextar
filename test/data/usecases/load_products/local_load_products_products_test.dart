import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalLoadProducts {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProducts({required this.fetchCacheStorage});
  Future<void> load() async {
    fetchCacheStorage.fetch('products');
  }
}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  Future<void> fetch(String key) =>
      this.noSuchMethod(Invocation.method(#fetch, [key]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadProducts sut;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProducts(fetchCacheStorage: fetchCacheStorage);
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('products')).called(1);
  });
}
