import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'cart_page_test.mocks.dart';

@GenerateMocks([AppPresenter, CartPresenter])
void main() {
  late MockAppPresenter appPresenterSpy;
  late StreamController<AppState> appController;
  late AppState initialAppState;

  late MockCartPresenter cartPresenterSpy;
  late StreamController<CartState> cartController;

  void setUpAppPresenter() {
    appPresenterSpy = MockAppPresenter();
    appController = StreamController.broadcast(sync: true);
    when(appPresenterSpy.stream).thenAnswer((_) => appController.stream);
    when(appPresenterSpy.state).thenReturn(initialAppState);

    GetIt.I.registerFactory<AppPresenter>(() => appPresenterSpy);
  }

  void setUpCartPresenter() {
    cartPresenterSpy = MockCartPresenter();
    cartController = StreamController.broadcast(sync: true);
    when(cartPresenterSpy.stream).thenAnswer((_) => cartController.stream);

    GetIt.I.registerFactory<CartPresenter>(() => cartPresenterSpy);
  }

  setUp(() {
    GetIt.I.reset();

    initialAppState = makeAppStateWithTwoCartItems();

    setUpAppPresenter();
    setUpCartPresenter();
  });

  Future<void> _loadPage(tester) async {
    await loadPage(tester, const Scaffold(body: CartPage()));

    appController.add(initialAppState);
    await tester.pump();
  }

  testWidgets('Should present empty message if cart is null or empty',
      (tester) async {
    initialAppState = makeAppStateWithEmptyCart();
    await _loadPage(tester);
    expect(find.text('Seu carrinho está vazio...'), findsOneWidget);

    initialAppState = makeAppStateWithoutCart();
    await _loadPage(tester);
    expect(find.text('Seu carrinho está vazio...'), findsOneWidget);
  });

  testWidgets('Should present cart items', (tester) async {
    await _loadPage(tester);

    expect(find.byType(CartItemListTile), findsNWidgets(2));
    expect(find.byType(RoundedIconButton), findsNWidgets(4));
    expect(
      find.text(initialAppState.cart!.items.first.product.name),
      findsOneWidget,
    );
  });

  testWidgets('Should increase item quantity', (tester) async {
    await _loadPage(tester);

    final button =
        find.byKey(Key("IncreaseItem${initialAppState.cart!.items.first.id}"));

    await tester.tap(button);
    await tester.pump();

    verify(cartPresenterSpy.increase(initialAppState.cart!.items.first))
        .called(1);
  });

  testWidgets('Should decrease item quantity', (tester) async {
    await _loadPage(tester);

    final button =
        find.byKey(Key("DecreaseItem${initialAppState.cart!.items.first.id}"));

    await tester.tap(button);
    await tester.pump();

    verify(cartPresenterSpy.decrease(initialAppState.cart!.items.first))
        .called(1);
  });

  testWidgets('Should remove item', (tester) async {
    await _loadPage(tester);

    final item = initialAppState.cart!.items.first;
    final dismissible = find.byKey(Key("Dismiss-${item.id}"));

    await tester.drag(dismissible, const Offset(-500, 0));
    await tester.pumpAndSettle();

    verify(cartPresenterSpy.removeItem(item)).called(1);
  });

  testWidgets('Should present order total value and checkout button',
      (tester) async {
    await _loadPage(tester);

    appController.add(initialAppState);
    await tester.pump();

    expect(find.byType(CartCheckoutContainer), findsOneWidget);
    expect(find.text("2 itens"), findsOneWidget);
    expect(find.text("FINALIZAR COMPRA"), findsOneWidget);
    expect(find.byType(LoadingElevatedButton), findsOneWidget);
  });

  testWidgets('Should open a modal with order data to confirmation',
      (tester) async {
    await _loadPage(tester);

    appController.add(initialAppState);
    await tester.pump();

    await tester.tap(find.text("FINALIZAR COMPRA"));
    await tester.pumpAndSettle();

    expect(find.byType(CartCheckoutBottomSheet), findsOneWidget);
    expect(find.text("Destinatário"), findsOneWidget);
    expect(find.text("Entrega"), findsOneWidget);
    expect(find.text("FINALIZAR COMPRA"), findsNWidgets(2));
  });
}
