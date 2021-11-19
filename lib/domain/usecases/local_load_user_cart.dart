import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalLoadUserCart implements LoadUserCart {
  final CacheStorage cacheStorage;
  static const _userCartKey = 'user_cart_';

  LocalLoadUserCart({required this.cacheStorage});

  @override
  Future<CartEntity?> load(String userId) async {
    try {
      final cart = await cacheStorage.fetch("$_userCartKey$userId");

      if (cart != null) {
        return CartModel.fromJson(cart).toEntity();
      }

      return null;
    } catch (error, trace) {
      Log.e("Load user cart error", data: error, trace: trace);
      throw LoadUserCartError();
    }
  }
}
