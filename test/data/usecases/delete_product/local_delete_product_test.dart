import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/usecases/usecases.dart';
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

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  @override
  Future<String> fetch(String key) => this.noSuchMethod(
        Invocation.method(#fetch, [key]),
        returnValue: Future.value(''),
        returnValueForMissingStub: Future.value(''),
      );
}

void main() {
  late DeleteCacheStorageSpy deleteCacheStorage;
  late FetchCacheStorageSpy fetchCacheStorage;
  late SaveCacheStorageSpy saveCacheStorage;
  late LocalDeleteProduct sut;
  late String key;

  PostExpectation mockSaveSecureCacheStorageCall() =>
      when(deleteCacheStorage.delete(key: key));

  mockError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    deleteCacheStorage = DeleteCacheStorageSpy();
    fetchCacheStorage = FetchCacheStorageSpy();
    saveCacheStorage = SaveCacheStorageSpy();
    sut = LocalDeleteProduct(
        deleteCacheStorage: deleteCacheStorage,
        fetchCacheStorage: fetchCacheStorage,
        saveCacheStorage: saveCacheStorage);
    key = 'any_key';
  });
  test('Should call DeleteCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(deleteCacheStorage.delete(key: key));
  });

  test('Should call FetchCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(fetchCacheStorage.fetch('products'));
  });

  test('Should save correct product list', () async {
    when(fetchCacheStorage.fetch('products'))
        .thenAnswer((_) async => '123,1234,12345,any_key');
    await sut.delete(key);

    verify(saveCacheStorage.save(key: 'products', value: '123,1234,12345'));
  });

  test('Should throw unexpected error if DeleteCacheStorage thorws', () async {
    mockError();

    final future = sut.delete(key);

    expect(future, throwsA(DomainError.unexpected));
  });
}
