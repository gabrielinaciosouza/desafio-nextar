import 'dart:io';

import 'package:get/get.dart';

import '../../domain/usecases/pick_image.dart';
import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/pages/pages.dart';
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
  final PickImage pickImage;
  String? productCode;

  GetxProductPresenter(
      {required this.validation,
      required this.deleteFromCache,
      required this.saveProduct,
      required this.loadProductByCode,
      required this.productCode,
      required this.pickImage});

  bool _isEditing = false;

  var _file = Rxn<File>();
  var _nameError = Rx<UIError>(UIError.none);
  var _codeError = Rx<UIError>(UIError.none);
  var _price = RxString('');
  var _stock = RxString('');
  var _code = RxString('');
  var _name = RxString('');
  ProductEntity? _product;

  Stream<UIError?>? get nameErrorStream => _nameError.stream;
  Stream<UIError?>? get codeErrorStream => _codeError.stream;
  Stream<File?>? get fileStream => _file.stream;
  Stream<String?>? get priceStream => _price.stream;
  Stream<String?>? get stockStream => _stock.stream;
  Stream<String?>? get codeStream => _code.stream;
  Stream<String?>? get nameStream => _name.stream;

  set price(value) => _price.value = value;
  set stock(value) => _stock.value = value;
  set code(value) => _code.value = value;
  set name(value) => _name.value = value;

  bool get isEditing => _isEditing;
  set isEditing(value) => _isEditing = value;

  ProductEntity? get product => _product;
  set product(value) => _product = value;

  void validateName(String value) {
    _name.value = value;
    _nameError.value =
        validateField(field: 'name', value: value, validation: validation);

    _validateForm();
  }

  void validateCode(String value) {
    _code.value = value;
    _codeError.value =
        validateField(field: 'code', value: value, validation: validation);
    _validateForm();
  }

  _validateForm() {
    isFormValid = _nameError.value == UIError.none &&
        _codeError.value == UIError.none &&
        _name.value != '' &&
        _code.value != '';
  }

  Future<void> submit() async {
    try {
      mainError = UIError.none;
      if ((!_price.value.isNumericOnly || !_stock.value.isNumericOnly) &&
          (_price.value.isNotEmpty || _stock.value.isNotEmpty)) {
        mainError = UIError.numericOnly;
        return;
      }
      isLoading = true;

      final product = ProductEntity(
          name: _name.value,
          code: _code.value,
          imagePath: _file.value != null ? _file.value!.path : '',
          creationDate: CustomizableDateTime.current,
          price: _price.value.isEmpty ? null : num.parse(_price.value),
          stock: _stock.value.isEmpty ? null : num.parse(_stock.value));
      if (isEditing) {
        await deleteFromCache.delete(productCode!);
      }
      await saveProduct.save(product);
      isLoading = false;
      navigateTo = '/home';
    } on DomainError catch (error) {
      mainError = error == DomainError.duplicatedCode
          ? UIError.duplicatedCode
          : UIError.unexpected;
    }
    isLoading = false;
  }

  @override
  void goToHomePage() {
    navigateTo = '/home';
  }

  @override
  Future<void> loadProduct() async {
    try {
      isLoading = true;
      mainError = UIError.none;

      if (productCode != null && productCode != '') {
        isEditing = true;
        product = await loadProductByCode.load(productCode!);
        print(product!.imagePath.toString());
        _code.value = product!.code;
        _name.value = product!.name;
        _file.value = product!.imagePath == null || product!.imagePath == ''
            ? null
            : File(product!.imagePath ?? '');
        _price.value = product!.price.toString();
        _stock.value = product!.stock.toString();
        isFormValid = true;
      }
    } catch (error) {
      mainError = UIError.unexpected;
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> pickFromCamera() async {
    var result = await pickImage.pickFromCamera();
    _file.value = result;
    if (result == null) {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> pickFromDevice() async {
    var result = await pickImage.pickFromDevice();
    _file.value = result;
    if (result == null) {
      mainError = UIError.unexpected;
    }
  }
}

extension CustomizableDateTime on DateTime {
  static DateTime customTime = DateTime.now();
  static DateTime get current => customTime;
}
