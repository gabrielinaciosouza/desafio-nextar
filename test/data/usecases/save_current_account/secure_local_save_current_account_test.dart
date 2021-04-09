import 'package:loja_virtual/data/cache/cache.dart';
import 'package:loja_virtual/data/usecases/save_current_account/secure_local_save_current_account.dart';
import 'package:loja_virtual/domain/entities/entities.dart';
import 'package:loja_virtual/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

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
  late SecureLocalSaveCurrentAccount sut;
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
    sut = SecureLocalSaveCurrentAccount(
        saveSecureCacheStorage: saveSecureCacheStorage);
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
