import 'package:grocery_store_app/domain/domain.dart';

import 'utils.dart';

OrderEntity makeOrder() {
  final user = makeUserEntity();

  return OrderEntity(
    user: user,
    date: DateTime.now(),
    address: user.mainAddress,
    items: [
      makeCartItem(price: 1.93, quantity: 5.1),
      makeCartItem(price: 2.99),
    ],
  );
}
