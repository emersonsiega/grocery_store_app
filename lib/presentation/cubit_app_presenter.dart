import 'package:bloc/bloc.dart';

import '../domain/domain.dart';
import '../view/view.dart';

class CubitAppPresenter extends Cubit<AppState> implements AppPresenter {
  final LoadProducts loadProducts;
  final LoadUserAccount loadUserAccount;
  final LoadUserCart loadUserCart;
  static const _defaultErrorMessage =
      "Não foi possível carregar alguns dados de seu último acesso...";

  CubitAppPresenter({
    required this.loadProducts,
    required this.loadUserAccount,
    required this.loadUserCart,
  }) : super(const AppState());

  @override
  Future<void> loadAppState() async {
    var partialState = const AppState(isLoading: true);
    bool hasError = false;

    emit(partialState);
    try {
      final products = await loadProducts.load();
      partialState = partialState.copyWith(products: products);
    } catch (_) {
      hasError = true;
    }

    try {
      final user = await loadUserAccount.load();
      partialState = partialState.copyWith(currentUser: user);

      CartEntity? cart;
      if (user != null) {
        cart = await loadUserCart.load(user.id);
        partialState = partialState.copyWith(cart: cart);
      }
    } catch (_) {
      hasError = true;
    }

    emit(
      partialState.copyWith(
        isLoading: false,
        errorMessage: hasError ? _defaultErrorMessage : null,
      ),
    );
  }

  @override
  void clearAppState() {
    emit(const AppState());
  }

  @override
  void updateCart(CartEntity cart) {
    emit(
      state.copyWith(cart: cart),
    );
  }
}
