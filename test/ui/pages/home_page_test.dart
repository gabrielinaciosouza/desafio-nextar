import 'dart:async';

import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:desafio_nextar/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class HomePresenterSpy extends Mock implements HomePresenter {
  Future<void> loadProducts() =>
      this.noSuchMethod(Invocation.method(#loadProducts, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late HomePresenterSpy presenter;
  late StreamController<bool> isLoadingController;
  late StreamController<List<ProductViewModel>> loadProductsController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    loadProductsController = StreamController<List<ProductViewModel>>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.loadProductsStream)
        .thenAnswer((_) => loadProductsController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    loadProductsController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = HomePresenterSpy();
    initStreams();
    mockStreams();
    final homePage = GetMaterialApp(initialRoute: '/home', getPages: [
      GetPage(name: '/home', page: () => HomePage(presenter: presenter))
    ]);
    await tester.pumpWidget(homePage);
  }

  List<ProductViewModel> makeProducts() => [
        ProductViewModel(
            name: 'Product 1',
            price: 30,
            stock: 10,
            code: 'any_code',
            creationDate: 'any_date'),
        ProductViewModel(
            name: 'Product 2',
            price: 20,
            stock: 15,
            code: 'any_code2',
            creationDate: 'any_date2'),
      ];

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call loadProducts on page load',
      (WidgetTester tester) async {
    await loadPage(tester);
    verify(presenter.loadProducts()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if loadProductStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadProductsController.addError(UIError.unexpected.description!);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Product 1'), findsNothing);
  });

  testWidgets('Should present list if loadProductStream succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadProductsController.add(makeProducts());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text('Product 2'), findsOneWidget);
    expect(find.text('R\$ ${30.toStringAsFixed(2)}'), findsOneWidget);
    expect(find.text('R\$ ${20.toStringAsFixed(2)}'), findsOneWidget);
  });
}
