import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/save_products.dart';
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
  final SaveProducts saveProducts;
  final Logoff logoffSession;
  GetxHomePresenter(
      {required this.loadProductsData,
      required this.logoffSession,
      required this.saveProducts});

  final _products = Rx<List<ProductViewModel>>([]);

  Stream<List<dynamic>?>? get productsStream => _products.stream;

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
      mainError = UIError.none;
      _products.value = [];

      _products.value.removeWhere((element) => element.code == code);
      final products = _products.value
          .map(
            (product) => ProductEntity(
              name: product.name,
              price: product.price,
              stock: product.stock,
              code: product.code,
              creationDate:
                  DateFormat('dd-MM-yyyy').parse(product.creationDate),
            ),
          )
          .toList();
      await saveProducts.save(products);
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
      await logoffSession.logoff();
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
}
