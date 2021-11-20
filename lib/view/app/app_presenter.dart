import '../../domain/domain.dart';
import '../view.dart';

abstract class AppPresenter extends BasePresenter<AppState> {
  Future<void> loadAppState();

  void clearAppState();

  void updateCart(CartEntity cart);
}
