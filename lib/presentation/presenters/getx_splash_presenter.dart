import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';

import '../../ui/pages/splash/splash.dart';

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
