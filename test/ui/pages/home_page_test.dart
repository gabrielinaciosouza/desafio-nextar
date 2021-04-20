import 'package:desafio_nextar/ui/pages/pages.dart';
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

  Future<void> loadPage(WidgetTester tester) async {
    presenter = HomePresenterSpy();
    final homePage = GetMaterialApp(initialRoute: '/home', getPages: [
      GetPage(name: '/home', page: () => HomePage(presenter: presenter))
    ]);
    await tester.pumpWidget(homePage);
  }

  testWidgets('Should call loadProducts on page load',
      (WidgetTester tester) async {
    await loadPage(tester);
    verify(presenter.loadProducts()).called(1);
  });
}
