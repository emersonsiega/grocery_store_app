import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:grocery_store_app/presentation/presentation.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'cubit_cart_presenter_test.mocks.dart';

@GenerateMocks([
  AppPresenter,
  SaveUserCart,
  MakeOrder,
  OrderReceiptPdfMaker,
])
void main() {
  late CubitCartPresenter sut;
  late MockAppPresenter appPresenterSpy;
  late StreamController<AppState> appController;
  late AppState appState;
  late MockSaveUserCart saveUserCartSpy;
  late MockMakeOrder makeOrderSpy;
  late MockOrderReceiptPdfMaker pdfMakerSpy;
  late String pdfPath;

  void setUpAppPresenter() {
    appPresenterSpy = MockAppPresenter();
    appController = StreamController.broadcast(sync: true);
    appState = makeAppStateWithCart();

    when(appPresenterSpy.stream).thenAnswer((_) => appController.stream);
    when(appPresenterSpy.state).thenAnswer((_) => appState);
  }

  PostExpectation mockPdfMakerCall() => when(pdfMakerSpy.makePdf(any));

  void mockPdfMakerSuccess(String path) {
    mockPdfMakerCall().thenAnswer((_) async => path);
  }

  void mockPdfMakerError() {
    mockPdfMakerCall().thenThrow(MakeOrderReceiptError());
  }

  void mockSaveUserCartError() {
    when(saveUserCartSpy.save(any)).thenThrow(SaveUserCartError());
  }

  setUp(() {
    saveUserCartSpy = MockSaveUserCart();
    makeOrderSpy = MockMakeOrder();
    pdfMakerSpy = MockOrderReceiptPdfMaker();
    setUpAppPresenter();

    sut = CubitCartPresenter(
      appPresenter: appPresenterSpy,
      saveUserCart: saveUserCartSpy,
      makeUserOrder: makeOrderSpy,
      pdfMaker: pdfMakerSpy,
    );

    pdfPath = faker.internet.httpUrl();
    mockPdfMakerSuccess(pdfPath);
  });

  test('Should increase cart item quantity', () async {
    final cartItemChanged = appState.cart!.items.first;

    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(isLoading: false),
      ]),
    );

    await sut.increase(cartItemChanged);

    final cart = appState.cart!;
    final newCart = CartEntity(
      id: cart.id,
      user: cart.user,
      items: [
        cartItemChanged.copyWith(quantity: cartItemChanged.quantity + 1),
      ],
    );

    verify(appPresenterSpy.updateCart(newCart)).called(1);
    verify(saveUserCartSpy.save(newCart)).called(1);
  });

  test('Should present error message if increase quantity fails', () async {
    mockSaveUserCartError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(
          isLoading: false,
          errorMessage: 'Não foi possível editar o item',
        ),
      ]),
    );

    await sut.increase(appState.cart!.items.first);
  });

  test('Should decrease cart item quantity', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(isLoading: false),
      ]),
    );

    final cartItemChanged = appState.cart!.items.first;
    await sut.decrease(cartItemChanged);

    final cart = appState.cart!;
    final newCart = CartEntity(
      id: cart.id,
      user: cart.user,
      items: [
        cartItemChanged.copyWith(quantity: cartItemChanged.quantity - 1),
      ],
    );

    verify(appPresenterSpy.updateCart(newCart)).called(1);
    verify(saveUserCartSpy.save(newCart)).called(1);
  });

  test('Should present error message if decrease quantity fails', () async {
    mockSaveUserCartError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(
          isLoading: false,
          errorMessage: 'Não foi possível editar o item',
        ),
      ]),
    );

    await sut.decrease(appState.cart!.items.first);
  });

  test('Should decrease cart item quantity to zero', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(isLoading: false),
      ]),
    );

    var cartItemChanged = appState.cart!.items.first;
    cartItemChanged = cartItemChanged.copyWith(quantity: 1);

    await sut.decrease(cartItemChanged);

    final cart = appState.cart!;
    final newCart = CartEntity(
      id: cart.id,
      user: cart.user,
      items: const [],
    );

    verify(appPresenterSpy.updateCart(newCart)).called(1);
    verify(saveUserCartSpy.save(newCart)).called(1);
  });

  test('Should remove cart item', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(isLoading: false),
      ]),
    );

    var cartItemChanged = appState.cart!.items.first;
    await sut.removeItem(cartItemChanged);

    final cart = appState.cart!;
    final newCart = CartEntity(
      id: cart.id,
      user: cart.user,
      items: const [],
    );

    verify(appPresenterSpy.updateCart(newCart)).called(1);
    verify(saveUserCartSpy.save(newCart)).called(1);
  });

  test('Should make order', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        CartState(
          isLoading: false,
          orderReceiptPath: pdfPath,
          successMessage: 'Pedido realizado com sucesso',
        ),
      ]),
    );

    await sut.makeOrder();

    verify(makeOrderSpy.save(any)).called(1);
    verify(pdfMakerSpy.makePdf(any)).called(1);
    verify(saveUserCartSpy.save(any)).called(1);
    verify(appPresenterSpy.updateCart(any)).called(1);
  });

  test('Should present error message if make order fail', () async {
    mockPdfMakerError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const CartState(isLoading: true),
        const CartState(
          isLoading: false,
          errorMessage: 'Não foi possível realizar o pedido',
        ),
      ]),
    );

    await sut.makeOrder();
  });
}
