import '../../helpers/helpers.dart';

abstract class ProductPresenter {
  Stream<UIError?>? get nameErrorStream;
  Stream<UIError?>? get codeErrorStream;
  Stream<UIError?>? get mainErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get navigateToStream;

  String get price;
  set price(value);
  String get stock;
  set stock(value);
  bool get isEditing;
  set isEditing(value);

  void validateName(String value);
  void validateCode(String value);

  void goToHomePage();
  void loadProduct();

  Future<void> submit();
}
