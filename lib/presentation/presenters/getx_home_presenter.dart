import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadProducts loadProductsData;
  final DeleteProduct deleteProductByCode;
  GetxHomePresenter(
      {required this.loadProductsData, required this.deleteProductByCode});

  final _isLoading = true.obs;
  final _products = Rx([]);
  final _deleteProduct = Rx(UIError.none);

  Stream<bool?> get isLoadingStream => _isLoading.stream;
  Stream<List<dynamic>?>? get productsStream => _products.stream;
  Stream<UIError?>? get deleteProductStream => _deleteProduct.stream;

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
    _isLoading.value = true;
    _deleteProduct.value = UIError.none;
    await deleteProductByCode.delete(code);
    _isLoading.value = false;
  }

  @override
  Future<void> logoff() {
    throw UnimplementedError();
  }
}
