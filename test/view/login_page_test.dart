import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_store_app/view/components/loading.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'login_page_test.mocks.dart';

@GenerateMocks([LoginPresenter])
void main() {
  late MockLoginPresenter loginPresenterSpy;
  late StreamController<LoginState> loginController;
  late String username;
  late String password;

  void setUpPresenter() {
    loginPresenterSpy = MockLoginPresenter();
    loginController = StreamController.broadcast(sync: true);
    when(loginPresenterSpy.stream).thenAnswer((_) => loginController.stream);

    GetIt.I.registerFactory<LoginPresenter>(() => loginPresenterSpy);
  }

  Future<void> enterUsername(WidgetTester tester, String text) async {
    await tester.enterText(find.byKey(const Key('username')), text);
    await tester.pump();
  }

  Future<void> enterPassword(WidgetTester tester, String text) async {
    await tester.enterText(find.byKey(const Key('password')), text);
    await tester.pump();
  }

  Future<void> tapConfirmButton(WidgetTester tester) async {
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();
  }

  setUp(() async {
    await GetIt.I.reset();

    setUpPresenter();

    username = faker.internet.userName();
    password = faker.internet.password();
  });

  testWidgets('Should start with default state', (WidgetTester tester) async {
    await loadPage(tester, const LoginPage());

    expect(find.text('Grocery Store'), findsOneWidget);
    expect(find.text('Usuário'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('ENTRAR'), findsOneWidget);
    expect(find.text('Não possui conta?'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
    expect(find.byType(Loading), findsNothing);
  });

  testWidgets('Should validate form on confirm', (WidgetTester tester) async {
    await loadPage(tester, const LoginPage());

    await tapConfirmButton(tester);

    expect(
      find.descendant(
        of: find.byKey(const Key('username')),
        matching: find.text('Campo obrigatório'),
      ),
      findsOneWidget,
    );

    expect(
      find.descendant(
        of: find.byKey(const Key('password')),
        matching: find.text('Campo obrigatório'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should call to LoginPresenter on confirm',
      (WidgetTester tester) async {
    await loadPage(tester, const LoginPage());

    await enterUsername(tester, username);
    await enterPassword(tester, password);

    await tapConfirmButton(tester);

    verify(
      loginPresenterSpy.authenticate(user: username, password: password),
    ).called(1);
  });

  testWidgets('Should navigate to next page if authentication succeeds',
      (WidgetTester tester) async {
    final routerSpy = await loadPageWithNavigation(tester, const LoginPage());

    loginController.add(const LoginState(completed: true));
    await tester.pump();

    verify(routerSpy.replace(any)).called(1);
  });

  testWidgets('Should present a message if authentication fails',
      (WidgetTester tester) async {
    await loadPage(tester, const LoginPage());

    final errorText = faker.lorem.sentence();
    loginController.add(LoginState(errorMessage: errorText));

    await tester.pumpAndSettle();

    expect(find.text(errorText), findsOneWidget);
  });
}
