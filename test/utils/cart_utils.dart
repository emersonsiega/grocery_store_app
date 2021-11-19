import 'package:faker/faker.dart';
import 'package:grocery_store_app/domain/domain.dart';

ProductEntity makeProduct(
  double price, {
  ProductUnitType type = ProductUnitType.unit,
}) {
  return ProductEntity(
    imagePath: faker.internet.httpUrl(),
    name: faker.lorem.word(),
    unitType: type,
    price: price,
  );
}

CartItemEntity makeCartItem({
  ProductEntity? product,
  double quantity = 1,
  double price = 1.00,
}) {
  return CartItemEntity(
    product: product ?? makeProduct(price),
    quantity: quantity,
  );
}

List<CartItemEntity> makeCartItems() {
  return [
    CartItemEntity(
      product: makeProduct(2.23, type: ProductUnitType.kg),
      quantity: 3,
    ), // R$ 6,69
    CartItemEntity(
      product: makeProduct(1.99),
      quantity: 1,
    ), // R$ 1,99
    CartItemEntity(
      product: makeProduct(1.99),
      quantity: 0,
    ), // R$ 0,00
    CartItemEntity(
      product: makeProduct(0.01),
      quantity: 3,
    ), // R$ 0,03
  ];
}
