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
    implements LocalLoadCurrentAccount {}

class LoadCurrentAccountComposite implements LoadCurrentAccount {
  final SecureLocalLoadCurrentAccount secure;
  final LocalLoadCurrentAccount local;

  LoadCurrentAccountComposite({
    required this.secure,
    required this.local,
  });

  @override
  Future<AccountEntity> load() async {
    return await secure.load();
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

  test('Should call secure load', () async {
    await sut.load();

    verify(secure.load()).called(1);
  });
}
