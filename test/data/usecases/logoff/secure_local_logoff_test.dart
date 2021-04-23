import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LogoffSecureCacheStorageSpy extends Mock
    implements DeleteSecureCacheStorage {
  @override
  Future<void> deleteSecure({required String key}) {
    return this.noSuchMethod(
        Invocation.method(
          #deleteSecure,
          [key],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

class LocalSecureDeleteProduct implements DeleteProduct {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  LocalSecureDeleteProduct({required this.deleteSecureCacheStorage});

  @override
  Future<void> delete(String code) async {
    try {
      return await deleteSecureCacheStorage.deleteSecure(key: code);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

void main() {
  late LogoffSecureCacheStorageSpy logoffSecureCacheStorage;
  late LocalSecureDeleteProduct sut;
  late String key;

  PostExpectation mockSaveSecureCacheStorageCall() =>
      when(logoffSecureCacheStorage.deleteSecure(key: key));

  mockError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    key = 'token';
    logoffSecureCacheStorage = LogoffSecureCacheStorageSpy();
    sut = LocalSecureDeleteProduct(
        deleteSecureCacheStorage: logoffSecureCacheStorage);
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(logoffSecureCacheStorage.deleteSecure(key: key));
  });

  test('Should throw unexpected error if DeleteCacheStorage thorws', () async {
    mockError();

    final future = sut.delete(key);

    expect(future, throwsA(DomainError.unexpected));
  });
}
