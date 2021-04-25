import 'package:desafio_nextar/ui/pages/pages.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';

import '../mixins/mixins.dart';
import '../protocols/protocols.dart';

class GetxProductPresenter extends GetxController
    with
        FormManager,
        ValidateFieldManager,
        UIErrorManager,
        LoadingManager,
        NavigationManager
    implements ProductPresenter {
  final Validation validation;
  final SaveProduct saveProduct;
  final DeleteFromCache deleteFromCache;
  final LoadProduct loadProductByCode;
  String? productCode;

  GetxProductPresenter(
      {required this.validation,
      required this.deleteFromCache,
      required this.saveProduct,
      required this.loadProductByCode,
      required this.productCode});

  String? _name;
  String? _code;
  String _price = '';
  String _stock = '';
  bool _isEditing = false;

  var _nameError = Rx<UIError>(UIError.none);
  var _codeError = Rx<UIError>(UIError.none);
  ProductEntity? _product;

  Stream<UIError?>? get nameErrorStream => _nameError.stream;
  Stream<UIError?>? get codeErrorStream => _codeError.stream;
  String get price => _price;
  set price(value) => _price = value;
  String get stock => _stock;
  set stock(value) => _stock = value;
  bool get isEditing => _isEditing;
  set isEditing(value) => _isEditing = value;
  ProductEntity? get product => _product;
  set product(value) => _product = value;

  void validateName(String value) {
    _name = value;
    _nameError.value =
        validateField(field: 'name', value: value, validation: validation);

    _validateForm();
  }

  void validateCode(String value) {
    _code = value;
    _codeError.value =
        validateField(field: 'code', value: value, validation: validation);
    _validateForm();
  }

  _validateForm() {
    isFormValid = _nameError.value == UIError.none &&
        _codeError.value == UIError.none &&
        _name != null &&
        _code != null;
  }

  Future<void> submit() async {
    try {
      mainError = UIError.none;
      if ((!price.isNumericOnly || !stock.isNumericOnly) &&
          (price.isNotEmpty || stock.isNotEmpty)) {
        mainError = UIError.numericOnly;
        return;
      }
      isLoading = true;

      final product = ProductEntity(
          name: _name!,
          code: _code!,
          creationDate: CustomizableDateTime.current,
          price: price.isEmpty ? null : num.parse(price),
          stock: stock.isEmpty ? null : num.parse(stock));
      if (isEditing) {
        await deleteFromCache.delete(_code!);
      }
      await saveProduct.save(product);
      isLoading = false;
      navigateTo = '/home';
    } on DomainError {
      mainError = UIError.unexpected;
    }
    isLoading = false;
  }

  @override
  void goToHomePage() {
    navigateTo = '/home';
  }

  @override
  Future<void> loadProduct() async {
    if (productCode != null && productCode != '') {
      isEditing = true;
      product = await loadProductByCode.load(productCode!);
    }
  }
}

extension CustomizableDateTime on DateTime {
  static DateTime customTime = DateTime.now();
  static DateTime get current => customTime;
}
