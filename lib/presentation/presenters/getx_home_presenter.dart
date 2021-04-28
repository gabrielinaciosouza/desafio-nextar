import 'dart:io';

import 'package:desafio_nextar/presentation/mixins/mixins.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController
    with NavigationManager, LoadingManager, UIErrorManager
    implements HomePresenter {
  final LoadProducts loadProductsData;
  final DeleteFromCache deleteProductByCode;
  final DeleteFromCache logoffSession;
  GetxHomePresenter(
      {required this.loadProductsData,
      required this.deleteProductByCode,
      required this.logoffSession});

  final _products = Rxn<List<ProductViewModel>>();

  Stream<List<ProductViewModel>?>? get productsStream => _products.stream;

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      final products = await loadProductsData.load();
      _products.value = products
          .map(
            (product) => ProductViewModel(
              name: product.name,
              price: product.price,
              stock: product.stock,
              code: product.code,
              imagePath:
                  product.imagePath == 'null' || product.imagePath == null
                      ? ''
                      : product.imagePath,
              creationDate:
                  DateFormat('dd-MM-yyyy').format(product.creationDate),
            ),
          )
          .toList();
    } on DomainError {
      mainError = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> deleteProduct(String code) async {
    try {
      isLoading = true;
      mainError = UIError.none;
      await deleteProductByCode.delete(code);
      await loadProducts();
    } on DomainError {
      mainError = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> logoff() async {
    try {
      isLoading = true;
      mainError = UIError.none;
      await logoffSession.delete('token');
      isLoading = false;
      navigateTo = '/login';
    } on DomainError {
      mainError = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }

  @override
  void goToEditProduct(String productCode) {
    navigateTo = '/product/$productCode/edit';
  }

  @override
  void goToNewProduct() {
    navigateTo = '/product/new';
  }
}
