import 'home.dart';

abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<ProductViewModel>>? get loadProductsStream;

  Future<void> loadProducts();
  Future<void> deleteProduct(String code);
}
