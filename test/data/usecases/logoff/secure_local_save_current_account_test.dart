import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LogoffCacheStorageSpy extends Mock implements DeleteCacheStorage {
  @override
  Future<void> delete({required String key}) {
    return this.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

class LocalLogoff implements DeleteFromCache {
  final DeleteCacheStorage deleteCacheStorage;

  LocalLogoff({required this.deleteCacheStorage});

  @override
  Future<void> delete(String key) async {
    await deleteCacheStorage.delete(key: key);
  }
}

void main() {
  late LogoffCacheStorageSpy logoffCacheStorage;
  late LocalLogoff sut;
  late String key;
  late AccountEntity account;

  PostExpectation mockLogoffCacheStorageCall() =>
      when(logoffCacheStorage.delete(key: key));

  mockError() {
    mockLogoffCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    key = 'any_key';
    logoffCacheStorage = LogoffCacheStorageSpy();
    sut = LocalLogoff(deleteCacheStorage: logoffCacheStorage);
    account = AccountEntity(token: key);
  });
  test('Should call LogoffCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(logoffCacheStorage.delete(key: key));
  });
}
