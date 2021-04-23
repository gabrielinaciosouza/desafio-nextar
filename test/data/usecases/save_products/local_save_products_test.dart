import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/data/usecases/usecases.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';

class SaveCacheStorageSpy extends Mock implements SaveCacheStorage {
  @override
  Future<void> save({required String key, required String value}) {
    return this.noSuchMethod(
        Invocation.method(
          #save,
          [key, value],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

void main() {
  late SaveCacheStorageSpy saveCacheStorage;
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
    sut = LocalSaveProduct(saveCacheStorage: saveCacheStorage);
    product = mockValidProduct();
  });
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(product);

    verify(saveCacheStorage.save(
        key: product.code, value: json.encode(sut.toJson(product))));
  });

  test('Should throw unexpected error if SaveCacheStorage thorws', () async {
    mockError();

    final future = sut.save(product);

    expect(future, throwsA(DomainError.unexpected));
  });
}
