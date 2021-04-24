import 'package:desafio_nextar/ui/helpers/errors/ui_error.dart';

import '../../../../ui/pages/pages.dart';
import 'package:flutter/material.dart';

Widget makeProductPage() {
  return ProductPage(FakeProductPresenter());
}

class FakeProductPresenter implements ProductPresenter {
  @override
  Stream<UIError?>? get codeErrorStream => throw UnimplementedError();

  @override
  Stream<bool?>? get isFormValidStream => throw UnimplementedError();

  @override
  Stream<bool?>? get isLoadingStream => throw UnimplementedError();

  @override
  Stream<UIError?>? get mainErrorStream => throw UnimplementedError();

  @override
  Stream<UIError?>? get nameErrorStream => throw UnimplementedError();

  @override
  Stream<String?>? get navigateToStream => throw UnimplementedError();

  @override
  Stream<UIError?>? get priceErrorStream => throw UnimplementedError();

  @override
  Stream<UIError?>? get stockErrorStream => throw UnimplementedError();

  @override
  Future<void> submit() {
    throw UnimplementedError();
  }

  @override
  Future<void> validateField(String field) {
    throw UnimplementedError();
  }
}
