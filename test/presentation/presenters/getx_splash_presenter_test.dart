import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/ui/pages/splash/splash.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({required this.loadCurrentAccount});
  var _navigateTo = RxString('');

  @override
  Stream<String?>? get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.token.isEmpty ? '/login' : '/home';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }
}

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
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async {
    sut.navigateToStream!.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.checkAccount();
  });

  test('Should go to login page on empty result', () async {
    mockLoadCurrentAccount(account: AccountEntity(token: ''));

    sut.navigateToStream!
        .listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream!
        .listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
