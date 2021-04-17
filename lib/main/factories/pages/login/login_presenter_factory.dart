import 'package:desafio_nextar/presentation/presenters/presenters.dart';

import '../../../../main/factories/usecases/usecases.dart';

import '../../../../ui/pages/login/login_presenter.dart';
import '../../factories.dart';

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication());
}
