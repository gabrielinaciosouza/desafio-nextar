import 'package:flutter/material.dart';

import '../../../../ui/pages/home/home.dart';

import '../../factories.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: makeHomePresenter(),
  );
}
