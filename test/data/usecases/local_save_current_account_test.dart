import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorageSpy saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  @override
  Future<void> saveSecure({required String key, required String value}) {
    return this.noSuchMethod(
        Invocation.method(
          #saveSecure,
          [key, value],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

void main() {
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late LocalSaveCurrentAccount sut;
  late String token;
  late AccountEntity account;

  PostExpectation mockSaveSecureCacheStorageCall() => when(
      saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));

  mockError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    token = 'any_token';
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(token: token);
  });
  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw unexpected error if SaveSecureCacheStorage thorws',
      () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
