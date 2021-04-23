import 'dart:convert';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
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

class LocalSaveProducts implements SaveProducts {
  final SaveCacheStorage saveCacheStorage;

  LocalSaveProducts({required this.saveCacheStorage});
  @override
  Future<void> save(List<ProductEntity> productList) async {
    List<Map<String, String>> map = toMap(productList);

    map.forEach((map) async {
      await saveCacheStorage.save(key: map['code']!, value: jsonEncode(map));
    });
  }

  List<Map<String, String>> toMap(List<ProductEntity> productList) =>
      productList.map((product) {
        Map<String, String> map = Map<String, String>();
        map['code'] = product.code;
        map['name'] = product.name;
        map['stock'] = product.stock.toString();
        map['price'] = product.price.toString();
        map['creationDate'] = product.creationDate.toIso8601String();
        return map;
      }).toList();
}

void main() {
  late SaveCacheStorageSpy saveCacheStorage;
  late LocalSaveProducts sut;
  late List<ProductEntity> productList;

  List<ProductEntity> mockValidProducts() => [
        ProductEntity(
            name: 'Product 1',
            code: 'any_code',
            creationDate: DateTime(2021, 4, 21)),
        ProductEntity(
            name: 'Product 2',
            code: 'any_code2',
            creationDate: DateTime(2021, 4, 20))
      ];

  setUp(() {
    saveCacheStorage = SaveCacheStorageSpy();
    sut = LocalSaveProducts(saveCacheStorage: saveCacheStorage);
    productList = mockValidProducts();
  });
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(productList);

    verify(saveCacheStorage.save(
        key: 'any_code', value: jsonEncode(sut.toMap(productList).first)));
    verify(saveCacheStorage.save(
        key: 'any_code2', value: jsonEncode(sut.toMap(productList)[1])));
  });
}
