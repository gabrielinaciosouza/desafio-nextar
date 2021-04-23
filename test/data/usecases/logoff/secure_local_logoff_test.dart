import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/data/usecases/save_current_account/secure_local_save_current_account.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
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
    return await deleteSecureCacheStorage.deleteSecure(key: code);
  }
}

void main() {
  late LogoffSecureCacheStorageSpy logoffSecureCacheStorage;
  late LocalSecureDeleteProduct sut;
  late String key;

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
}
