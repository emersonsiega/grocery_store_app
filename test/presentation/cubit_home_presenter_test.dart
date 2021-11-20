import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:grocery_store_app/presentation/presentation.dart';
import 'package:grocery_store_app/view/home/home.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'cubit_home_presenter_test.mocks.dart';

@GenerateMocks([AppPresenter, SaveUserCart])
void main() {
  late CubitHomePresenter sut;
  late MockAppPresenter appPresenterSpy;
  late MockSaveUserCart saveUserCartSpy;
  late AppState currentAppState;

  void mockAppPresenterState(AppState state) {
    when(appPresenterSpy.state).thenReturn(state);
  }

  void mockSaveCartError() {
    when(saveUserCartSpy.save(any)).thenThrow(SaveUserCartError());
  }

  setUp(() {
    appPresenterSpy = MockAppPresenter();
    saveUserCartSpy = MockSaveUserCart();

    sut = CubitHomePresenter(
      appPresenter: appPresenterSpy,
      saveUserCart: saveUserCartSpy,
    );

    currentAppState = makeAppStateWithEmptyCart();
    mockAppPresenterState(currentAppState);
  });

  test('Should add product to empty cart', () async {
    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(isLoading: false, successMessage: "Produto adicionado"),
      ]),
    );

    final product = makeProduct(1.99);
    await sut.addToCart(product);

    verify(saveUserCartSpy.save(any)).called(1);
    verify(appPresenterSpy.updateCart(any)).called(1);
  });

  test('Should add new product to cart with items', () async {
    currentAppState = makeAppStateWithCart();
    mockAppPresenterState(currentAppState);

    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(isLoading: false, successMessage: "Produto adicionado"),
      ]),
    );

    await sut.addToCart(makeProduct(1.99));

    verify(saveUserCartSpy.save(any)).called(1);
    verify(appPresenterSpy.updateCart(any)).called(1);
  });

  test('Should create new Cart and add a product', () async {
    currentAppState = makeAppStateWithoutCart();
    mockAppPresenterState(currentAppState);

    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(isLoading: false, successMessage: "Produto adicionado"),
      ]),
    );

    await sut.addToCart(makeProduct(1.99));

    verify(saveUserCartSpy.save(any)).called(1);
    verify(appPresenterSpy.updateCart(any)).called(1);
  });

  test('Should present error message if add to cart fails', () async {
    mockSaveCartError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(
          isLoading: false,
          errorMessage: "Não foi possível adicionar o produto",
        ),
      ]),
    );

    await sut.addToCart(makeProduct(1.99));

    verify(saveUserCartSpy.save(any)).called(1);
    verifyNever(appPresenterSpy.updateCart(any));
  });

  test('Should remove product from cart', () async {
    currentAppState = makeAppStateWithCart();
    mockAppPresenterState(currentAppState);

    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(isLoading: false, successMessage: "Produto removido"),
      ]),
    );

    await sut.removeFromCart(currentAppState.cart!.items.first.product);

    verify(saveUserCartSpy.save(any)).called(1);
    verify(appPresenterSpy.updateCart(any)).called(1);
  });

  test('Should present error message if remove from cart fails', () async {
    currentAppState = makeAppStateWithCart();
    mockAppPresenterState(currentAppState);
    mockSaveCartError();

    expectLater(
      sut.stream,
      emitsInOrder([
        const HomeState(isLoading: true),
        const HomeState(
          isLoading: false,
          errorMessage: "Não foi possível remover o produto",
        ),
      ]),
    );

    await sut.removeFromCart(currentAppState.cart!.items.first.product);

    verify(saveUserCartSpy.save(any)).called(1);
    verifyNever(appPresenterSpy.updateCart(any));
  });
}
