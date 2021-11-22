import '../../domain.dart';

abstract class LoadUserOrders {
  Future<List<OrderEntity>> load(UserEntity user);
}
