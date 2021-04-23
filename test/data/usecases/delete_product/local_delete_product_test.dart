import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/usecases/delete_product.dart';
import 'package:desafio_nextar/data/cache/cache.dart';
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
    try {
      return await deleteCacheStorage.delete(key: code);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

void main() {
  late DeleteCacheStorageSpy deleteCacheStorage;
  late LocalDeleteProduct sut;
  late String key;

  PostExpectation mockSaveSecureCacheStorageCall() =>
      when(deleteCacheStorage.delete(key: key));

  mockError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    deleteCacheStorage = DeleteCacheStorageSpy();
    sut = LocalDeleteProduct(deleteCacheStorage: deleteCacheStorage);
    key = 'any_key';
  });
  test('Should call DeleteCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(deleteCacheStorage.delete(key: key));
  });

  test('Should throw unexpected error if DeleteCacheStorage thorws', () async {
    mockError();

    final future = sut.delete(key);

    expect(future, throwsA(DomainError.unexpected));
  });
}
