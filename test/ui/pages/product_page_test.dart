import 'dart:async';

import 'package:loja_virtual/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:loja_virtual/ui/pages/pages.dart';

class ProductPresenterSpy extends Mock implements ProductPresenter {
  @override
  Future<void> validateName(String field) =>
      this.noSuchMethod(Invocation.method(#validateName, []),
          returnValue: Future.value(''),
          returnValueForMissingStub: Future.value(''));
  @override
  Future<void> validateCode(String field) =>
      this.noSuchMethod(Invocation.method(#validateCode, []),
          returnValue: Future.value(''),
          returnValueForMissingStub: Future.value(''));
  @override
  Future<void> submit() => this.noSuchMethod(Invocation.method(#submit, []),
      returnValue: Future.value(), returnValueForMissingStub: Future.value());
  @override
  Future<void> loadProduct() =>
      this.noSuchMethod(Invocation.method(#loadProduct, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
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
    nameErrorController = StreamController<UIError?>.broadcast();
    codeErrorController = StreamController<UIError?>.broadcast();
    priceErrorController = StreamController<UIError?>.broadcast();
    stockErrorController = StreamController<UIError?>.broadcast();
    mainErrorController = StreamController<UIError>.broadcast();
    navigateToController = StreamController<String>.broadcast();
    isFormValidController = StreamController<bool>.broadcast();
    isLoadingController = StreamController<bool>.broadcast();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.codeErrorStream)
        .thenAnswer((_) => codeErrorController.stream);
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
    verify(presenter.validateName(name));

    final code = 'any_code';
    await tester.enterText(find.bySemanticsLabel('Código'), code);
    verify(presenter.validateCode(code));

    verify(presenter.loadProduct());
  });

  testWidgets('Should present error if name is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo inválido'), findsOneWidget);
  });

  testWidgets('Should present error if name is empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should present no error if name is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(null);
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel('Nome'), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets('Should present error if code is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    codeErrorController.add(UIError.invalidField);
    await tester.pump();

    expect(find.text('Campo inválido'), findsOneWidget);
  });

  testWidgets('Should present error if code is empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    codeErrorController.add(UIError.requiredField);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should present no error if code is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    codeErrorController.add(null);
    await tester.pump();

    expect(
        find.descendant(
            of: find.bySemanticsLabel('Código'), matching: find.byType(Text)),
        findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call submit on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pumpAndSettle();
    ElevatedButton elevatedButton = find
        .widgetWithText(ElevatedButton, 'Salvar')
        .evaluate()
        .first
        .widget as ElevatedButton;
    elevatedButton.onPressed!();
    await tester.pump();

    verify(presenter.submit()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if submit fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();

    expect(Get.currentRoute, '/product');
  });
}
