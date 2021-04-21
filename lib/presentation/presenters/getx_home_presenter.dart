import 'package:desafio_nextar/presentation/mixins/mixins.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController
    with NavigationManager, LoadingManager
    implements HomePresenter {
  final LoadProducts loadProductsData;
  final DeleteProduct deleteProductByCode;
  final Logoff logoffSession;
  GetxHomePresenter(
      {required this.loadProductsData,
      required this.deleteProductByCode,
      required this.logoffSession});

  final _products = Rx([]);
  final _error = Rx(UIError.none);

  Stream<List<dynamic>?>? get productsStream => _products.stream;
  Stream<UIError?>? get errorStream => _error.stream;

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
              creationDate:
                  DateFormat('dd-MM-yyyy').format(product.creationDate),
            ),
          )
          .toList();
    } on DomainError {
      _products.subject.addError(UIError.unexpected.description!);
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> deleteProduct(String code) async {
    try {
      isLoading = true;
      _error.value = UIError.none;
      await deleteProductByCode.delete(code);
    } on DomainError {
      _error.value = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> logoff() async {
    try {
      isLoading = true;
      _error.value = UIError.none;
      await logoffSession.logoff();
      isLoading = false;
      navigateTo = '/login';
    } on DomainError {
      _error.value = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }
}
