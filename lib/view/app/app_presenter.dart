import '../../domain/domain.dart';
import '../view.dart';

abstract class AppPresenter {
  Stream<AppState> get stream;

  Future<void> loadAppState();

  void clearAppState();

  void updateCart(CartEntity cart);
}
