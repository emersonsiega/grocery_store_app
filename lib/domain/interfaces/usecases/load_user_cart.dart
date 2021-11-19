import '../../domain.dart';

abstract class LoadUserCart {
  Future<CartEntity?> load(String userId);
}
