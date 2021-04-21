import 'package:desafio_nextar/data/models/models.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalLoadProducts {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProducts({required this.fetchCacheStorage});
  Future<List<ProductEntity>> load() async {
    final data = await fetchCacheStorage.fetch('products');
    if (data.isEmpty) {
      throw DomainError.unexpected;
    }
    return data
        .map<ProductEntity>(
            (json) => LocalProductModel.fromJson(json).toEntity())
        .toList();
  }
}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
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
  late List<Map> data;

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

  void mockFetch(List<Map> list) {
    data = list;
    when(fetchCacheStorage.fetch('products')).thenAnswer((_) async => list);
  }

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
          name: data[0]['name'] ?? '',
          code: data[0]['code'] ?? '',
          creationDate: DateTime.parse(data[0]['creationDate']!),
          price: num.parse(data[0]['price']!),
          stock: num.parse(data[0]['stock']!)),
      ProductEntity(
          name: data[1]['name'] ?? '',
          code: data[1]['code'] ?? '',
          creationDate: DateTime.parse(data[1]['creationDate']!),
          price: num.parse(data[1]['price']!),
          stock: num.parse(data[1]['stock']!))
    ]);
  });

  test('Should throw UnexpectedError if cache is empty', () async {
    mockFetch([]);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
