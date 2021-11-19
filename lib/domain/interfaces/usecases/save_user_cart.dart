import '../../domain.dart';

abstract class SaveUserCart {
  Future<void> save(CartEntity cart);
}
