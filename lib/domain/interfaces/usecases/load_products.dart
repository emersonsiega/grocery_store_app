import '../../domain.dart';

abstract class LoadProducts {
  Future<List<ProductEntity>> load();
}
