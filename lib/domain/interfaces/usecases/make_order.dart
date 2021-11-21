import '../../domain.dart';

abstract class MakeOrder {
  Future<void> save(OrderEntity order);
}
