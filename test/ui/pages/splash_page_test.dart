import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

abstract class SplashPresenter {
  Future<void> checkAccount();
  Stream<String> get navigateToStream;
}

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  SplashPage({required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Builder(builder: (context) {
        presenter.navigateToStream.listen((page) {
          if (page.isNotEmpty) {
            Get.offAllNamed(page);
          }
        });
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

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
}
