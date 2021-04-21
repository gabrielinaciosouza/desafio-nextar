import 'package:flutter/material.dart';

import '../../../../ui/pages/home/home.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: FakePresenter(),
  );
}

class FakePresenter implements HomePresenter {
  //just for compile
  @override
  Future<void> loadProducts() {
    throw UnimplementedError();
  }

  @override
  Stream<bool?>? get isLoadingStream => throw UnimplementedError();

  @override
  Stream<List<ProductViewModel>>? get loadProductsStream =>
      throw UnimplementedError();

  @override
  deleteProduct(String code) {
    throw UnimplementedError();
  }

  @override
  Future<void> logoff() {
    throw UnimplementedError();
  }
}
