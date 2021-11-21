import 'package:grocery_store_app/domain/domain.dart';
import 'package:grocery_store_app/view/view.dart';

import 'user_entity_utils.dart';
import 'utils.dart';

List<ProductEntity> get _stateProducts => [
      makeProduct(1.00),
      makeProduct(1.99),
      makeProduct(10),
      makeProduct(2.90, type: ProductUnitType.kg),
    ];

AppState makeAppStateWithEmptyCart() {
  final user = makeUserEntity();

  final items = <CartItemEntity>[];

  return AppState(
    currentUser: user,
    products: _stateProducts,
    cart: CartEntity(
      id: user.id,
      user: user,
      items: items,
    ),
  );
}

AppState makeAppStateWithCart() {
  final user = makeUserEntity();
  final products = _stateProducts;

  return AppState(
    currentUser: user,
    products: products,
    cart: CartEntity(
      id: user.id,
      user: user,
      items: [
        makeCartItem(product: products.first, quantity: 2),
      ],
    ),
  );
}

AppState makeAppStateWithoutCart() {
  return AppState(
    currentUser: makeUserEntity(),
    products: _stateProducts,
  );
}
