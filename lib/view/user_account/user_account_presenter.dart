import '../../domain/domain.dart';
import '../view.dart';
import 'user_account_state.dart';

abstract class UserAccountPresenter extends BasePresenter<UserAccountState> {
  Future<void> loadOrders(UserEntity user);

  Future<void> printOrder(OrderEntity order);
}
