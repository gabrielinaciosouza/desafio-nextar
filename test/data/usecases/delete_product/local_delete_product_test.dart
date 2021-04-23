import 'dart:convert';
import 'package:desafio_nextar/domain/usecases/delete_product.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/data/usecases/usecases.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';

class DeleteCacheStorageSpy extends Mock implements DeleteCacheStorage {
  @override
  Future<void> delete({required String key}) {
    return this.noSuchMethod(
        Invocation.method(
          #save,
          [key],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

class LocalDeleteProduct implements DeleteProduct {
  final DeleteCacheStorage deleteCacheStorage;
  LocalDeleteProduct({required this.deleteCacheStorage});

  @override
  Future<void> delete(String code) async {
    return await deleteCacheStorage.delete(key: code);
  }
}

void main() {
  late DeleteCacheStorageSpy deleteCacheStorage;
  late LocalDeleteProduct sut;
  late String key;

  setUp(() {
    deleteCacheStorage = DeleteCacheStorageSpy();
    sut = LocalDeleteProduct(deleteCacheStorage: deleteCacheStorage);
    key = 'any_key';
  });
  test('Should call DeleteCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(deleteCacheStorage.delete(key: key));
  });
}
