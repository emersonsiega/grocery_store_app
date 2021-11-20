import '../../domain/domain.dart';
import '../view.dart';

abstract class HomePresenter extends BasePresenter<HomeState> {
  Future<void> addToCart(ProductEntity productEntity);

  Future<void> removeFromCart(ProductEntity productEntity);
}
