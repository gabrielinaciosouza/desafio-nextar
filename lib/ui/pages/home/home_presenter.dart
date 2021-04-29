import '../../helpers/errors/errors.dart';

import 'home.dart';

abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<ProductViewModel>?>? get productsStream;
  Stream<UIError?>? get mainErrorStream;
  Stream<String?>? get navigateToStream;

  Future<void> loadProducts();
  Future<void> deleteProduct(String code);
  Future<void> logoff();

  void goToEditProduct(String productCode);
  void goToNewProduct();
  void dateFilter({required bool increasing});
  void priceFilter({required bool increasing});
  void alphabeticFilter({required bool increasing});
}
