import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:desafio_nextar/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {
  void validateEmail(String email) =>
      this.noSuchMethod(Invocation.method(#validateEmail, [email]),
          returnValue: null, returnValueForMissingStub: null);
  void validatePassword(String password) =>
      this.noSuchMethod(Invocation.method(#validatePassword, [password]),
          returnValue: null, returnValueForMissingStub: null);
}

void main() {
  late LoginPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'when a TextFormFild has only one text child means it has no errors, since one of the childs is always the label text');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget,
        reason:
            'when a TextFormFild has only one text child means it has no errors, since one of the childs is always the label text');

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = 'mail@test.com';
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = 'any_password';
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));
  });
}
