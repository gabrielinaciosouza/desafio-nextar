import 'package:desafio_nextar/data/usecases/local_load_products/local_load_products.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/domain_error.dart';

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  Future<void> fetch(String key) =>
      this.noSuchMethod(Invocation.method(#fetch, [key]),
          returnValue: Future.value('123'),
          returnValueForMissingStub: Future.value('123'));
}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadProducts sut;

  PostExpectation mockFetchCall() => when(fetchCacheStorage.fetch('products'));

  PostExpectation mockFetchCall2() => when(fetchCacheStorage.fetch('any_code'));

  void mockFetch(String? value) {
    mockFetchCall().thenAnswer((_) async => value);
  }

  void mockFetch2(String? value) {
    mockFetchCall2().thenAnswer((_) async => value);
  }

  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProducts(fetchCacheStorage: fetchCacheStorage);
    mockFetch('any_code');
    mockFetch2(
        '{"name":"123","code":"1234","creationDate":"2021-04-25T17:27:28.933953","price":"12345","stock":"123456"}');
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('products')).called(1);
  });

  test('Should return a list of products on success', () async {
    final products = await sut.load();

    expect(products, [
      ProductEntity(
          name: '123',
          code: '1234',
          creationDate: DateTime.parse('2021-04-25T17:27:28.933953'),
          price: num.parse('12345'),
          stock: num.parse('123456'))
    ]);
  });

  test('Should return empty list if cache is empty', () async {
    mockFetch('');
    final emptyList = await sut.load();

    expect(emptyList, []);
  });

  test('Should return empty list if cache is null', () async {
    mockFetch(null);
    final emptyList = await sut.load();

    expect(emptyList, []);
  });

  test('Should throw UnexpectedError if cache is invalid', () async {
    mockFetch2('{"invalid": "20"}');
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is incomplete', () async {
    mockFetch('{"price": "20"}');
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache throws', () async {
    mockFetchError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
