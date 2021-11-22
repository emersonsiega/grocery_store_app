import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([HomePresenter, AppPresenter])
void main() {
  late MockHomePresenter presenterSpy;
  late StreamController<HomeState> homeController;

  late MockAppPresenter appPresenterSpy;
  late StreamController<AppState> appController;
  late AppState initialAppState;

  void setUpHomePresenter() {
    presenterSpy = MockHomePresenter();
    homeController = StreamController.broadcast(sync: true);
    when(presenterSpy.stream).thenAnswer((_) => homeController.stream);

    GetIt.I.registerFactory<HomePresenter>(() => presenterSpy);
  }

  void setUpAppPresenter() {
    appPresenterSpy = MockAppPresenter();
    appController = StreamController.broadcast(sync: true);
    when(appPresenterSpy.stream).thenAnswer((_) => appController.stream);
    when(appPresenterSpy.state).thenAnswer((_) => initialAppState);

    GetIt.I.registerFactory<AppPresenter>(() => appPresenterSpy);
  }

  void mockAppPresenterInitialState(state) {
    appController.add(state);
  }

  tearDown(() {
    appController.close();
    homeController.close();
  });

  setUp(() async {
    await GetIt.I.reset();

    initialAppState = makeAppStateWithEmptyCart();

    setUpAppPresenter();
    setUpHomePresenter();
  });

  Future<void> _loadPage(tester) async {
    await loadPage(tester, const Scaffold(body: HomePage()));

    mockAppPresenterInitialState(initialAppState);
    await tester.pump();
  }

  Future<void> enterSearchText(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(ProductFilter), text);
    await tester.pump();
  }

  testWidgets('Should start with default state', (tester) async {
    await _loadPage(tester);

    expect(find.text("Pesquisar"), findsOneWidget);
    expect(find.byType(ProductFilter), findsOneWidget);
    expect(find.text("Produtos"), findsOneWidget);
    expect(
      find.byType(ProductListTile),
      findsNWidgets(initialAppState.products!.length),
    );
  });

  testWidgets('Should filter products by name with debounce', (tester) async {
    await _loadPage(tester);

    final text = initialAppState.products!.first.name;

    await enterSearchText(tester, text);

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(ProductListTile), findsOneWidget);
  });

  testWidgets('Should present an icon to remove the filter text',
      (tester) async {
    await _loadPage(tester);

    final text = initialAppState.products!.first.name;

    await enterSearchText(tester, text);
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('clearFilter')), findsOneWidget);
  });

  testWidgets('Should present a text for empty results', (tester) async {
    await _loadPage(tester);

    await enterSearchText(tester, faker.lorem.sentence());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("Nenhum produto encontrado..."), findsOneWidget);
  });

  testWidgets('Should present add button for products not in the cart',
      (tester) async {
    await _loadPage(tester);

    final firstItem = initialAppState.products!.first.id;

    expect(
      find.descendant(
        of: find.byKey(Key('addOrRemove-$firstItem')),
        matching: find.text('ADICIONAR'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should present remove button for products in the cart',
      (tester) async {
    initialAppState = makeAppStateWithCart();

    await _loadPage(tester);

    final firstItem = initialAppState.products!.first.id;

    expect(
      find.descendant(
        of: find.byKey(Key('addOrRemove-$firstItem')),
        matching: find.text('REMOVER'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should add product to cart', (tester) async {
    await _loadPage(tester);

    final firstItem = initialAppState.products!.first;

    await tester.tap(find.byKey(Key('addOrRemove-${firstItem.id}')));
    await tester.pump();

    verify(presenterSpy.addToCart(firstItem)).called(1);
  });

  testWidgets('Should remove product from cart', (tester) async {
    initialAppState = makeAppStateWithCart();

    await _loadPage(tester);

    final firstItem = initialAppState.products!.first;

    await tester.tap(find.byKey(Key('addOrRemove-${firstItem.id}')));
    await tester.pump();

    verify(presenterSpy.removeFromCart(firstItem)).called(1);
  });

  testWidgets('Should present success messages', (tester) async {
    await _loadPage(tester);

    final message = faker.lorem.sentence();
    homeController.add(HomeState(successMessage: message));
    await tester.pumpAndSettle();

    expect(find.text(message), findsOneWidget);
  });

  testWidgets('Should present error messages', (tester) async {
    await _loadPage(tester);

    final message = faker.lorem.sentence();
    homeController.add(HomeState(errorMessage: message));
    await tester.pumpAndSettle();

    expect(find.text(message), findsOneWidget);
  });
}
