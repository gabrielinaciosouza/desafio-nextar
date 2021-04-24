import '../../helpers/helpers.dart';

abstract class ProductPresenter {
  Stream<UIError?>? get nameErrorStream;
  Stream<UIError?>? get codeErrorStream;
  Stream<UIError?>? get priceErrorStream;
  Stream<UIError?>? get stockErrorStream;
  Stream<UIError?>? get mainErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get navigateToStream;

  Future<void> submit();
  Future<void> validateField(String field);
}
