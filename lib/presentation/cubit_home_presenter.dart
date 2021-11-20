import 'package:bloc/bloc.dart';

import '../domain/domain.dart';
import '../view/home/home.dart';
import '../view/view.dart';

class CubitHomePresenter extends Cubit<HomeState> implements HomePresenter {
  final AppPresenter appPresenter;
  final SaveUserCart saveUserCart;

  CubitHomePresenter({
    required this.appPresenter,
    required this.saveUserCart,
  }) : super(const HomeState());

  @override
  Future<void> addToCart(ProductEntity productEntity) async {
    try {
      emit(const HomeState(isLoading: true));

      final cartItem = CartItemEntity(product: productEntity, quantity: 1);

      CartEntity? cart = appPresenter.state.cart;

      if (cart == null) {
        cart = CartEntity(
          user: appPresenter.state.currentUser!,
          items: [cartItem],
        );
      } else {
        cart.addItem(cartItem);
      }

      await saveUserCart.save(cart);
      appPresenter.updateCart(cart);

      emit(const HomeState(successMessage: "Produto adicionado"));
    } catch (_) {
      emit(
        const HomeState(errorMessage: "Não foi possível adicionar o produto"),
      );
    }
  }

  @override
  Future<void> removeFromCart(ProductEntity productEntity) async {
    try {
      emit(const HomeState(isLoading: true));

      CartEntity? cart = appPresenter.state.cart;
      if (cart != null) {
        final item = cart.items.firstWhere(
          (item) => item.product.id == productEntity.id,
        );

        cart.removeItem(item);
        await saveUserCart.save(cart);
        appPresenter.updateCart(cart);
      }

      emit(const HomeState(successMessage: "Produto removido"));
    } catch (_) {
      emit(
        const HomeState(errorMessage: "Não foi possível remover o produto"),
      );
    }
  }
}
