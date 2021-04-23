import 'dart:convert';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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

class LocalSaveProduct implements SaveProduct {
  final SaveCacheStorage saveCacheStorage;

  LocalSaveProduct({required this.saveCacheStorage});
  @override
  Future<void> save(ProductEntity product) async {
    try {
      await saveCacheStorage.save(
          key: product.code, value: json.encode(toJson(product)));
    } catch (error) {
      print(error.toString());
      throw DomainError.unexpected;
    }
  }

  Map<String, String> toJson(ProductEntity product) {
    final Map<String, String> data = new Map<String, String>();
    data['name'] = product.name;
    data['code'] = product.code;
    data['creationDate'] = product.creationDate.toIso8601String();
    data['price'] = product.price.toString();
    data['stock'] = product.stock.toString();
    return data;
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
