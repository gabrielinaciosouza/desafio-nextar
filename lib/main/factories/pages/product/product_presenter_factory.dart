import 'product_validation_factory.dart';
import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

ProductPresenter makeGetxProductPresenter(String? productCode) {
  return GetxProductPresenter(
      validation: makeProductValidation(),
      deleteFromCache: makeLocalDeleteProduct(),
      saveProduct: makeLocalSaveProduct(),
      loadProductByCode: makeLocalLoadProduct(),
      productCode: productCode);
}
