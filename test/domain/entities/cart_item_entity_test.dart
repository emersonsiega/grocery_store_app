import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';

import '../../utils/utils.dart';

void main() {
  test('Should return the correct total value', () async {
    var sut = CartItemEntity(
      product: makeProduct(2.23, type: ProductUnitType.kg),
      quantity: 3,
    );
    expect(sut.total, 6.69);

    sut = CartItemEntity(
      product: makeProduct(0.01),
      quantity: 10,
    );
    expect(sut.total, 0.10);
  });

  test('Should return the correct total value with empty quantity', () async {
    final sut = CartItemEntity(
      product: makeProduct(2.23),
      quantity: 0,
    );

    expect(sut.total, 0.0);
  });

  test('Should return the correct total value with decimal quantity', () async {
    final sut = CartItemEntity(
      product: makeProduct(1.99),
      quantity: 0.1,
    );

    expect(sut.total, 0.2);
  });

  test('Should edit the cart item quantity', () async {
    final sut = CartItemEntity(
      product: makeProduct(1.99),
      quantity: 0.1,
    );

    final newSut = sut.copyWith(quantity: 1.01);

    expect(newSut.total, 2.01);
    expect(newSut.quantity, 1.01);
    expect(newSut.product, sut.product);
  });
}
