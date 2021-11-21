import '../../domain/domain.dart';
import '../view.dart';

abstract class CartPresenter extends BasePresenter<CartState> {
  Future<void> increase(CartItemEntity cartItem);
  Future<void> decrease(CartItemEntity cartItem);

  Future<void> removeItem(CartItemEntity cartItem);

  Future<void> makeOrder();
}
