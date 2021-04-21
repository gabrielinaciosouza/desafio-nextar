import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/presentation/presenters/presenters.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  @override
  Future<AccountEntity> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(AccountEntity(token: 'any_token')),
          returnValueForMissingStub:
              Future.value(AccountEntity(token: 'any_token')));
}

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccountSpy loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  PostExpectation mockLoadCurrentAccountCall() =>
      when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({required AccountEntity account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async {
    sut.navigateToStream!.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on empty result', () async {
    mockLoadCurrentAccount(account: AccountEntity(token: ''));

    sut.navigateToStream!
        .listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream!
        .listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
