import '../../data/cache/cache.dart';
import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalMakeOrder implements MakeOrder {
  final CacheStorage cacheStorage;
  static const _makeOrderKey = "user_orders_";

  LocalMakeOrder({required this.cacheStorage});

  @override
  Future<void> save(OrderEntity order) async {
    try {
      final newOrderModel = OrderModel.fromEntity(order);

      final orders = await cacheStorage.fetch("$_makeOrderKey${order.user.id}");

      List<OrderModel> userOrders = [];
      if (orders != null) {
        userOrders = List<Map<String, dynamic>>.from(orders)
            .map((item) => OrderModel.fromJson(item))
            .toList();
      }

      userOrders.add(newOrderModel);

      final json = userOrders.map((e) => e.toJson()).toList();

      await cacheStorage.save(
        key: "$_makeOrderKey${order.user.id}",
        value: json,
      );
    } catch (error, trace) {
      Log.e("Save order error", data: error, trace: trace);
      throw MakeOrderError();
    }
  }
}
