import 'package:desafio_nextar/main/factories/usecases/usecases.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/home/home.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: FakePresenter(),
  );
}

// HomePresenter makeHomePresenter() => GetxHomePresenter(
//   deleteProductByCode: makeLocalDeleteProduct(),
//   loadProductsData: makeLocalLoadProducts(),
//   logoffSession:
// );

class FakePresenter implements HomePresenter {
  //just for compile
  @override
  Future<void> loadProducts() {
    throw UnimplementedError();
  }

  @override
  Stream<bool?>? get isLoadingStream => throw UnimplementedError();

  @override
  Stream<List<ProductViewModel>>? get productsStream =>
      throw UnimplementedError();

  @override
  deleteProduct(String code) {
    throw UnimplementedError();
  }

  @override
  Future<void> logoff() {
    throw UnimplementedError();
  }

  @override
  Stream<String?>? get navigateToStream => throw UnimplementedError();

  @override
  Stream<UIError?>? get mainErrorStream => throw UnimplementedError();

  @override
  void goToEditProduct(String productCode) {}

  @override
  void goToNewProduct() {}
}
