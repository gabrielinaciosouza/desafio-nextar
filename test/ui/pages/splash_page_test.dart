import 'dart:async';

import 'package:desafio_nextar/ui/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  final Stream<String> response;
  SplashPresenterSpy({required this.response});
  @override
  Future<void> checkAccount({durationInSeconds: 0}) =>
      this.noSuchMethod(Invocation.method(#checkAccount, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());

  @override
  Stream<String> get navigateToStream =>
      this.noSuchMethod(Invocation.getter(#navigateToStream),
          returnValue: response, returnValueForMissingStub: response);
}

void main() {
  late SplashPresenterSpy presenter;
  late StreamController<String> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    navigateToController = StreamController<String>();
    presenter = SplashPresenterSpy(response: navigateToController.stream);
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(
            name: '/any_route',
            page: () => Scaffold(
                  body: Text('fake page'),
                )),
      ],
    ));
  }

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();

    expect(Get.currentRoute, '/');
  });
}
