import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalLoadProducts implements LoadProducts {
  final CacheStorage cacheStorage;
  static const _productListKey = 'product_list';

  LocalLoadProducts({required this.cacheStorage});

  @override
  Future<List<ProductEntity>> load() async {
    try {
      final products = await cacheStorage.fetch(_productListKey);
      final entities = List<Map<String, dynamic>>.from(products)
          .map((item) => ProductModel.fromJson(item).toEntity())
          .toList();

      return entities;
    } catch (error, trace) {
      Log.e("Load products  error", data: error, trace: trace);
      throw LoadProductsError();
    }
  }
}
