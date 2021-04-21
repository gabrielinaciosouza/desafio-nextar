abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;

  Future<void> loadProducts();
}
