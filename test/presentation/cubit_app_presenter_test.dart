import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:grocery_store_app/presentation/presentation.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/user_entity_utils.dart';
import '../utils/utils.dart';
import 'cubit_app_presenter_test.mocks.dart';

@GenerateMocks([LoadProducts, LoadUserAccount, LoadUserCart])
void main() {
  late CubitAppPresenter sut;
  late MockLoadProducts loadProductsSpy;
  late MockLoadUserAccount loadUserAccountSpy;
  late MockLoadUserCart loadUserCartSpy;
  late UserEntity user;
  late List<ProductEntity> products;
  late CartEntity cart;

  PostExpectation loadProductsCall() => when(loadProductsSpy.load());

  mockLoadProductsSuccess(List<ProductEntity> products) {
    loadProductsCall().thenAnswer((_) async => products);
  }

  mockLoadProductsError() {
    loadProductsCall().thenThrow(LoadProductsError());
  }

  PostExpectation mockLoadUserCall() => when(loadUserAccountSpy.load());

  mockLoadUserSuccess(UserEntity? user) {
    mockLoadUserCall().thenAnswer((_) async => user);
  }

  mockLoadUserError() {
    mockLoadUserCall().thenThrow(LoadUserAccountError());
  }

  PostExpectation mockLoadCartCall() => when(loadUserCartSpy.load(any));

  mockLoadCartSuccess(CartEntity? cart) {
    mockLoadCartCall().thenAnswer((_) async => cart);
  }

  mockLoadCartError() {
    mockLoadCartCall().thenThrow(LoadUserCartError());
  }

  setUp(() {
    loadProductsSpy = MockLoadProducts();
    loadUserAccountSpy = MockLoadUserAccount();
    loadUserCartSpy = MockLoadUserCart();
    user = makeUserEntity();
    products = [makeProduct(10.00), makeProduct(1.99)];
    cart = CartEntity(
      user: user,
      items: [
        makeCartItem(product: products[0]),
        makeCartItem(product: products[1]),
      ],
    );

    sut = CubitAppPresenter(
      loadProducts: loadProductsSpy,
      loadUserAccount: loadUserAccountSpy,
      loadUserCart: loadUserCartSpy,
    );

    mockLoadProductsSuccess(products);
    mockLoadUserSuccess(user);
    mockLoadCartSuccess(cart);
  });

  test('Should load initial app state with user data', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const AppState(isLoading: true),
        AppState(
          isLoading: false,
          currentUser: user,
          products: products,
          cart: cart,
        ),
      ]),
    );

    await sut.loadAppState();

    verify(loadProductsSpy.load()).called(1);
    verify(loadUserAccountSpy.load()).called(1);
    verify(loadUserCartSpy.load(user.id)).called(1);
  });

  test('Should load initial app state without user data', () async {
    mockLoadUserSuccess(null);

    expectLater(
      sut.stream,
      emitsInOrder([
        const AppState(isLoading: true),
        AppState(
          isLoading: false,
          products: products,
        ),
      ]),
    );

    await sut.loadAppState();

    verify(loadProductsSpy.load()).called(1);
    verify(loadUserAccountSpy.load()).called(1);
  });

  test('Should clear app state', () async {
    expectLater(
      sut.stream,
      emitsInOrder([const AppState()]),
    );

    sut.clearAppState();
  });

  test('Should update cart', () async {
    cart.addItem(makeCartItem());

    expectLater(
      sut.stream,
      emitsInOrder([
        AppState(cart: cart),
      ]),
    );

    sut.updateCart(cart);
  });

  test('Should emit error message if load products fails', () async {
    mockLoadProductsError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const AppState(isLoading: true),
        AppState(
          isLoading: false,
          currentUser: user,
          cart: cart,
          errorMessage:
              "Não foi possível carregar alguns dados de seu último acesso...",
        ),
      ]),
    );

    await sut.loadAppState();
  });

  test('Should emit error message if load user fails', () async {
    mockLoadUserError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const AppState(isLoading: true),
        AppState(
          isLoading: false,
          products: products,
          errorMessage:
              "Não foi possível carregar alguns dados de seu último acesso...",
        ),
      ]),
    );

    await sut.loadAppState();
  });

  test('Should emit error message if load cart fails', () async {
    mockLoadCartError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const AppState(isLoading: true),
        AppState(
          isLoading: false,
          products: products,
          currentUser: user,
          errorMessage:
              "Não foi possível carregar alguns dados de seu último acesso...",
        ),
      ]),
    );

    await sut.loadAppState();
  });
}
