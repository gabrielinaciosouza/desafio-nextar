import '../../../../ui/pages/pages.dart';
import 'package:flutter/material.dart';

import 'product_presenter_factory.dart';

Widget makeProductPage() {
  return ProductPage(makeGetxProductPresenter());
}
