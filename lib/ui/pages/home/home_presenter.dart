import 'package:desafio_nextar/ui/helpers/errors/errors.dart';

abstract class HomePresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<dynamic>?>? get productsStream;
  Stream<UIError?>? get deleteProductErrorStream;

  Future<void> loadProducts();
  Future<void> deleteProduct(String code);
  Future<void> logoff();
}
