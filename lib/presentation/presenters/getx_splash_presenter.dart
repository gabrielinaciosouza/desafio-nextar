import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../mixins/mixins.dart';
import '../../ui/pages/splash/splash.dart';

class GetxSplashPresenter extends GetxController
    with NavigationManager
    implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Future<void> checkAccount({int durationInSeconds = 3}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      navigateTo = account.token.isEmpty ? '/login' : '/home';
    } catch (error) {
      navigateTo = '/login';
    }
  }
}
