import 'package:desafio_nextar/data/cache/cache.dart';
import 'package:desafio_nextar/data/usecases/save_current_account/save_current_account.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
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

void main() {
  late SaveCacheStorageSpy saveCacheStorage;
  late LocalSaveCurrentAccount sut;
  late String token;
  late AccountEntity account;

  PostExpectation mockSaveCacheStorageCall() =>
      when(saveCacheStorage.save(key: 'token', value: account.token));

  mockError() {
    mockSaveCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    token = 'any_token';
    saveCacheStorage = SaveCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveCacheStorage: saveCacheStorage);
    account = AccountEntity(token: token);
  });
  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(account);

    verify(saveCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throw unexpected error if SaveCacheStorage thorws', () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
