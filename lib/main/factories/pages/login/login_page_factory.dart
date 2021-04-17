import 'package:flutter/material.dart';

import '../../factories.dart';
import '../../../../ui/pages/login/login_page.dart';

Widget makeLoginPage() {
  return LoginPage(makeGetxLoginPresenter());
}
