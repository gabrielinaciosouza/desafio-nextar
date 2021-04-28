import 'dart:io';

import '../../../domain/entities/entities.dart';

import '../../helpers/helpers.dart';

abstract class ProductPresenter {
  Stream<UIError?>? get nameErrorStream;
  Stream<UIError?>? get codeErrorStream;
  Stream<UIError?>? get mainErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get navigateToStream;
  Stream<String?>? get priceStream;
  Stream<String?>? get stockStream;
  Stream<String?>? get nameStream;
  Stream<String?>? get codeStream;
  Stream<File?>? get fileStream;

  bool get isEditing;
  set isEditing(value);

  ProductEntity? get product;
  set product(value);
  set stock(value);
  set price(value);
  set code(value);
  set name(value);

  void validateName(String value);
  void validateCode(String value);
  Future<void> pickFromDevice();
  Future<void> pickFromCamera();

  void goToHomePage();
  Future<void> loadProduct();

  Future<void> submit();
}
