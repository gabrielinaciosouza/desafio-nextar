import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:loja_virtual/data/cache/cache.dart';
import 'package:loja_virtual/data/usecases/usecases.dart';
import 'package:loja_virtual/domain/entities/entities.dart';
import 'package:loja_virtual/domain/helpers/helpers.dart';

class SaveCacheStorageSpy extends Mock implements SaveCacheStorage {
  @override
  Future<void> save({required String key, required String value}) {
    return this.noSuchMethod(
        Invocation.method(
          #save,
          [key, value],
        ),
        returnValue: Future.value(''),
        returnValueForMissingStub: Future.value(''));
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  @override
  Future<String> fetch(String key) => this.noSuchMethod(
        Invocation.method(#fetch, [key]),
        returnValue: Future.value(''),
        returnValueForMissingStub: Future.value(''),
      );
}

void main() {
  late SaveCacheStorageSpy saveCacheStorage;
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalSaveProduct sut;
  late ProductEntity product;

  ProductEntity mockValidProduct() => ProductEntity(
      name: 'Product 1', code: 'any_code', creationDate: DateTime(2021, 4, 21));

  PostExpectation mockSaveSecureCacheStorageCall() => when(saveCacheStorage
      .save(key: product.code, value: json.encode(sut.toJson(product))));

  mockError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    saveCacheStorage = SaveCacheStorageSpy();
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalSaveProduct(
        saveCacheStorage: saveCacheStorage,
        fetchCacheStorage: fetchCacheStorage);
    product = mockValidProduct();
  });
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(product);

    verify(saveCacheStorage.save(
        key: product.code, value: json.encode(sut.toJson(product))));
  });

  test('Should call FetchCacheStorage with correct values', () async {
    await sut.save(product);

    verify(fetchCacheStorage.fetch('products'));
  });

  test('Should save correct product list values', () async {
    await sut.save(product);

    verify(saveCacheStorage.save(key: 'products', value: product.code));
  });

  test('Should save correct product list values when has data in memory',
      () async {
    when(fetchCacheStorage.fetch('products'))
        .thenAnswer((_) async => '123,1234');
    await sut.save(product);

    verify(saveCacheStorage.save(key: 'products', value: '123,1234,any_code'));
  });

  test('Should throw unexpected error if SaveCacheStorage thorws', () async {
    mockError();

    final future = sut.save(product);

    expect(future, throwsA(DomainError.unexpected));
  });
}
