import 'dart:async';

import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:desafio_nextar/ui/pages/pages.dart';

class ProductPresenterSpy extends Mock implements ProductPresenter {
  @override
  Future<void> validateField(String field) =>
      this.noSuchMethod(Invocation.method(#validateField, []),
          returnValue: Future.value(''),
          returnValueForMissingStub: Future.value(''));
}

void main() {
  ProductPresenter presenter = ProductPresenterSpy();
  late StreamController<UIError?> nameErrorController;
  late StreamController<UIError?> codeErrorController;
  late StreamController<UIError?> priceErrorController;
  late StreamController<UIError?> stockErrorController;
  late StreamController<UIError> mainErrorController;
  late StreamController<String> navigateToController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    nameErrorController = StreamController<UIError?>();
    codeErrorController = StreamController<UIError?>();
    priceErrorController = StreamController<UIError?>();
    stockErrorController = StreamController<UIError?>();
    mainErrorController = StreamController<UIError>();
    navigateToController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.codeErrorStream)
        .thenAnswer((_) => codeErrorController.stream);
    when(presenter.priceErrorStream)
        .thenAnswer((_) => priceErrorController.stream);
    when(presenter.stockErrorStream)
        .thenAnswer((_) => stockErrorController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    codeErrorController.close();
    priceErrorController.close();
    stockErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    navigateToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    initStreams();
    mockStreams();

    final loginPage = GetMaterialApp(initialRoute: '/product', getPages: [
      GetPage(
        name: '/product',
        page: () => ProductPage(presenter),
      ),
      GetPage(
        name: '/any_route',
        page: () => Scaffold(
          body: Text('fake page'),
        ),
      ),
    ]);

    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = 'any_name';
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(presenter.validateField(name));

    final code = 'any_code';
    await tester.enterText(find.bySemanticsLabel('Código'), code);
    verify(presenter.validateField(code));
  });

  testWidgets('Should present error if name is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo inválido'), findsOneWidget);
  });
}
