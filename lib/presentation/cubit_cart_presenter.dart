import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/data.dart';
import '../domain/domain.dart';
import '../infra/infra.dart';
import '../view/view.dart';

class CubitCartPresenter extends Cubit<CartState> implements CartPresenter {
  final AppPresenter appPresenter;
  final SaveUserCart saveUserCart;
  final MakeOrder makeUserOrder;
  final OrderReceiptPdfMaker pdfMaker;

  CubitCartPresenter({
    required this.appPresenter,
    required this.saveUserCart,
    required this.makeUserOrder,
    required this.pdfMaker,
  }) : super(const CartState());

  @override
  Future<void> decrease(CartItemEntity cartItem) async {
    try {
      emit(const CartState(isLoading: true));

      final cart = appPresenter.state.cart!;
      List<CartItemEntity>? items = [];

      if (cartItem.quantity == 1) {
        items = cart.removeItem(cartItem);
      } else {
        items = cart.editItem(
          cartItem.copyWith(quantity: cartItem.quantity - 1),
        );
      }

      final newCart = cart.copyWith(items: items);
      await saveUserCart.save(newCart);
      appPresenter.updateCart(newCart);

      emit(const CartState(isLoading: false));
    } catch (_) {
      emit(
        const CartState(
          isLoading: false,
          errorMessage: "Não foi possível editar o item",
        ),
      );
    }
  }

  @override
  Future<void> increase(CartItemEntity cartItem) async {
    try {
      emit(const CartState(isLoading: true));

      final cart = appPresenter.state.cart!;
      final items = cart.editItem(
        cartItem.copyWith(quantity: cartItem.quantity + 1),
      );

      final newCart = cart.copyWith(items: items);
      await saveUserCart.save(newCart);
      appPresenter.updateCart(newCart);

      emit(const CartState(isLoading: false));
    } catch (_) {
      emit(
        const CartState(
          isLoading: false,
          errorMessage: "Não foi possível editar o item",
        ),
      );
    }
  }

  @override
  Future<void> removeItem(CartItemEntity cartItem) async {
    emit(const CartState(isLoading: true));

    final cart = appPresenter.state.cart!;
    final items = cart.removeItem(cartItem);

    final newCart = cart.copyWith(items: items);
    await saveUserCart.save(newCart);
    appPresenter.updateCart(newCart);

    emit(const CartState(isLoading: false));
  }

  @override
  Future<void> makeOrder() async {
    try {
      emit(const CartState(isLoading: true));

      final order = OrderEntity.fromCart(appPresenter.state.cart!);
      await makeUserOrder.save(order);
      final pdfPath = await pdfMaker.makePdf(order);

      final itemsList = <CartItemEntity>[];
      final emptyCart = CartEntity(user: order.user, items: itemsList);
      await saveUserCart.save(emptyCart);
      appPresenter.updateCart(emptyCart);

      emit(
        CartState(
          isLoading: false,
          orderReceiptPath: pdfPath,
          successMessage: 'Pedido realizado com sucesso',
        ),
      );
    } catch (error, trace) {
      Log.e('Failed to make order', data: error, trace: trace);
      emit(const CartState(
        isLoading: false,
        errorMessage: "Não foi possível realizar o pedido",
      ));
    }
  }
}
