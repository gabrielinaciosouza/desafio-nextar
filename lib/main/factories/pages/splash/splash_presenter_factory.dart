import 'package:desafio_nextar/main/factories/composites/composites.dart';

import '../../../../ui/pages/splash/splash.dart';

import '../../../../presentation/presenters/presenters.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(
      loadCurrentAccount: makeLoadCurrentAccountComposite());
}
