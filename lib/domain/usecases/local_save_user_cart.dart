import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalSaveUserCart implements SaveUserCart {
  static const _userCartKey = 'user_cart_';
  final CacheStorage cacheStorage;

  LocalSaveUserCart({
    required this.cacheStorage,
  });

  @override
  Future<void> save(CartEntity cart) async {
    try {
      final json = CartModel.fromEntity(cart).toJson();
      await cacheStorage.save(key: "$_userCartKey${cart.user.id}", value: json);
    } catch (error, trace) {
      Log.e("Save user cart error", data: error, trace: trace);
      throw SaveUserCartError();
    }
  }
}
