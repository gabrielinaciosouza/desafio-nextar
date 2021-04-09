import 'package:loja_virtual/data/usecases/load_current_account/load_current_account.dart';
import 'package:loja_virtual/domain/entities/account_entity.dart';
import 'package:loja_virtual/main/composites/composites.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SecureLoadCurrentAccountSpy extends Mock
    implements SecureLocalLoadCurrentAccount {
  @override
  Future<AccountEntity> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(AccountEntity(token: 'any')),
          returnValueForMissingStub: Future.value(AccountEntity(token: 'any')));
}

class LocalLoadCurrentAccountSpy extends Mock
    implements LocalLoadCurrentAccount {
  @override
  Future<AccountEntity> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(AccountEntity(token: 'any')),
          returnValueForMissingStub: Future.value(AccountEntity(token: 'any')));
}

void main() {
  late LoadCurrentAccountComposite sut;
  late SecureLoadCurrentAccountSpy secure;
  late LocalLoadCurrentAccountSpy local;

  setUp(() {
    secure = SecureLoadCurrentAccountSpy();
    local = LocalLoadCurrentAccountSpy();
    sut = LoadCurrentAccountComposite(secure: secure, local: local);
  });

  void throwSecureError() {
    when(secure.load()).thenThrow(Exception());
  }

  void throwLocalError() {
    when(local.load()).thenThrow(Exception());
  }

  test('Should call secure load', () async {
    await sut.load();

    verify(secure.load()).called(1);
  });

  test('Should call local load if secure fails', () async {
    throwSecureError();
    await sut.load();

    verify(local.load()).called(1);
  });

  test('Should return an account os secure success', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: 'any'));
  });

  test('Should return an account os secure fails', () async {
    throwSecureError();
    final account = await sut.load();

    expect(account, AccountEntity(token: 'any'));
  });

  test('Should throw if local throws', () async {
    throwSecureError();
    throwLocalError();
    final future = sut.load();

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
