import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:loja_virtual/data/cache/cache.dart';
import 'package:loja_virtual/data/usecases/usecases.dart';

import 'package:loja_virtual/domain/entities/entities.dart';
import 'package:loja_virtual/domain/helpers/domain_error.dart';

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  Future<void> fetch(String key) =>
      this.noSuchMethod(Invocation.method(#fetch, [key]),
          returnValue: Future.value('123'),
          returnValueForMissingStub: Future.value('123'));
}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadProduct sut;
  late String code;

  PostExpectation mockFetchCall() => when(fetchCacheStorage.fetch(code));

  void mockFetch(String? value) {
    mockFetchCall().thenAnswer((_) async => value);
  }

  void mockFetchError() => mockFetchCall().thenThrow(Exception());

  setUp(() {
    code = 'any_code';
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProduct(fetchCacheStorage: fetchCacheStorage);
    mockFetch(
        '{"name":"123","code":"1234","creationDate":"2021-04-25T17:27:28.933953","price":"12345","stock":"123456"}');
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load(code);

    verify(fetchCacheStorage.fetch(code)).called(1);
  });

  test('Should return a product on success', () async {
    final product = await sut.load(code);

    expect(
        product,
        ProductEntity(
            name: '123',
            code: '1234',
            creationDate: DateTime.parse('2021-04-25T17:27:28.933953'),
            price: num.parse('12345'),
            stock: num.parse('123456')));
  });

  test('Should return null list if cache is empty', () async {
    mockFetch('');
    final empty = await sut.load(code);

    expect(empty, null);
  });

  test('Should return null list if cache is null', () async {
    mockFetch(null);
    final nullResult = await sut.load(code);

    expect(nullResult, null);
  });

  test('Should throw UnexpectedError if cache is invalid', () async {
    mockFetch('{"invalid": "20"}');
    final future = sut.load(code);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is incomplete', () async {
    mockFetch('{"price": "20"}');
    final future = sut.load(code);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache throws', () async {
    mockFetchError();

    final future = sut.load(code);

    expect(future, throwsA(DomainError.unexpected));
  });
}
