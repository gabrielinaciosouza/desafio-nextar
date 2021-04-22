import 'package:desafio_nextar/data/usecases/load_current_account/load_current_account.dart';
import 'package:desafio_nextar/domain/entities/account_entity.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
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

class LoadCurrentAccountComposite implements LoadCurrentAccount {
  final SecureLocalLoadCurrentAccount secure;
  final LocalLoadCurrentAccount local;

  LoadCurrentAccountComposite({
    required this.secure,
    required this.local,
  });

  @override
  Future<AccountEntity> load() async {
    try {
      return await secure.load();
    } catch (error) {
      return await local.load();
    }
  }
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
}
