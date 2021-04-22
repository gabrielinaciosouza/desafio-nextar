import '../../../factories/usecases/usecases.dart';
import '../../../../ui/pages/splash/splash.dart';

import '../../../../presentation/presenters/presenters.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(
      loadCurrentAccount: makeSecureLocalLoadCurrentAccount());
}
