import '../../data/cache/cache.dart';
import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalLoadUserOrders implements LoadUserOrders {
  final CacheStorage cacheStorage;
  static const _loadOrdersKey = "user_orders_";

  LocalLoadUserOrders({required this.cacheStorage});

  @override
  Future<List<OrderEntity>> load(UserEntity user) async {
    try {
      final orders = await cacheStorage.fetch("$_loadOrdersKey${user.id}");

      List<OrderEntity> userOrders = [];

      if (orders != null) {
        userOrders = List<Map<String, dynamic>>.from(orders)
            .map((item) => OrderModel.fromJson(item).toEntity())
            .toList();
      }

      return userOrders;
    } catch (error, trace) {
      Log.e("Load user orders error", data: error, trace: trace);
      throw LoadUserOrdersError();
    }
  }
}
