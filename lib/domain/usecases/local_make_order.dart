import '../../data/cache/cache.dart';
import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalMakeOrder implements MakeOrder {
  final CacheStorage cacheStorage;
  static const _makeOrderKey = "order_user_";

  LocalMakeOrder({required this.cacheStorage});

  @override
  Future<void> save(OrderEntity order) async {
    try {
      final json = OrderModel.fromEntity(order).toJson();

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
