import 'home.dart';

abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<ProductViewModel>>? get productsStream;

  Future<void> loadProducts();
  Future<void> deleteProduct(String code);
  Future<void> logoff();
}
