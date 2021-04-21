abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<dynamic>?>? get productsStream;

  Future<void> loadProducts();
  Future<void> deleteProduct(String code);
  Future<void> logoff();
}
