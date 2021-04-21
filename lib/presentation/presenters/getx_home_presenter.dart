import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadProducts loadProductsData;
  final DeleteProduct deleteProductByCode;
  final Logoff logoffSession;
  GetxHomePresenter(
      {required this.loadProductsData,
      required this.deleteProductByCode,
      required this.logoffSession});

  final _isLoading = true.obs;
  final _products = Rx([]);
  final _deleteProductError = Rx(UIError.none);

  Stream<bool?> get isLoadingStream => _isLoading.stream;
  Stream<List<dynamic>?>? get productsStream => _products.stream;
  Stream<UIError?>? get deleteProductErrorStream => _deleteProductError.stream;

  Future<void> loadProducts() async {
    try {
      _isLoading.value = true;
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
      _isLoading.value = false;
    }
  }

  @override
  Future<void> deleteProduct(String code) async {
    try {
      _isLoading.value = true;
      _deleteProductError.value = UIError.none;
      await deleteProductByCode.delete(code);
    } on DomainError {
      _deleteProductError.value = UIError.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> logoff() async {
    await logoffSession.logoff();
  }
}
