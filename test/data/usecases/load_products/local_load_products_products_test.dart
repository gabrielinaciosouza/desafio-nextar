import 'package:desafio_nextar/data/usecases/local_load_products/local_load_products.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/domain_error.dart';

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  Future<void> fetch(String key) =>
      this.noSuchMethod(Invocation.method(#fetch, [key]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadProducts sut;
  List<Map>? data;

  List<Map> mockValidData() => [
        {
          'name': 'any_name',
          'price': '20',
          'stock': '10',
          'code': 'any_code',
          'creationDate': '2021-04-20T00:00:00Z',
        },
        {
          'name': 'any_name2',
          'price': '30',
          'stock': '15',
          'code': 'any_code2',
          'creationDate': '2021-04-21T00:00:00Z',
        }
      ];

  PostExpectation mockFetchCall() => when(fetchCacheStorage.fetch('products'));

  void mockFetch(List<Map>? list) {
    data = list;
    mockFetchCall().thenAnswer((_) async => list);
  }

  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProducts(fetchCacheStorage: fetchCacheStorage);
    mockFetch(mockValidData());
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('products')).called(1);
  });

  test('Should return a list of products on success', () async {
    final products = await sut.load();

    expect(products, [
      ProductEntity(
          name: data![0]['name'],
          code: data![0]['code'],
          creationDate: DateTime.parse(data![0]['creationDate']!),
          price: num.parse(data![0]['price']!),
          stock: num.parse(data![0]['stock']!)),
      ProductEntity(
          name: data![1]['name'],
          code: data![1]['code'],
          creationDate: DateTime.parse(data![1]['creationDate']!),
          price: num.parse(data![1]['price']!),
          stock: num.parse(data![1]['stock']!))
    ]);
  });

  test('Should throw UnexpectedError if cache is empty', () async {
    mockFetch([]);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is null', () async {
    mockFetch(null);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is invalid', () async {
    mockFetch([
      {
        'name': 'any_name',
        'price': 'invalid_price',
        'stock': 'invalid_stock',
        'code': 'any_code',
        'creationDate': 'invalid_date',
      }
    ]);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is incomplete', () async {
    mockFetch([
      {
        'price': '20',
        'stock': '10',
      }
    ]);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache throws', () async {
    mockFetchError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
