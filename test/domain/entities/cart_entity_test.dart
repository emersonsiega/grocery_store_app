import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';

import '../../utils/utils.dart';

void main() {
  test('Should return the correct total value', () async {
    final sut = CartEntity(
      user: makeUserEntity(),
      items: makeCartItems(),
    );

    expect(sut.total, 8.71);
  });

  test('Should return zero if there is no items', () async {
    final sut = CartEntity(user: makeUserEntity(), items: const []);

    expect(sut.total, 0.00);
  });

  test('Should add the first item', () async {
    List<CartItemEntity> items = [];
    final sut = CartEntity(
      user: makeUserEntity(),
      items: items,
    );
    expect(sut.totalItems, 0);

    sut.addItem(makeCartItem());
    expect(sut.totalItems, 1);
  });

  test('Should add a new item', () async {
    final sut = CartEntity(
      user: makeUserEntity(),
      items: makeCartItems(),
    );

    expect(sut.totalItems, 4);

    sut.addItem(makeCartItem());

    expect(sut.totalItems, 5);
  });

  test('Should throw a CartItemAlreadyExistsError if add the same item twice',
      () async {
    List<CartItemEntity> items = [];
    final sut = CartEntity(
      user: makeUserEntity(),
      items: items,
    );

    final item = makeCartItem();

    sut.addItem(item);

    expect(
      () => sut.addItem(item),
      throwsA(const TypeMatcher<CartItemAlreadyExistsError>()),
    );
  });

  test('Should edit an existent item', () async {
    final item = makeCartItem(quantity: 1, price: 1);
    final sut = CartEntity(
      user: makeUserEntity(),
      items: [item],
    );

    expect(sut.totalItems, 1);
    expect(sut.total, 1.00);

    sut.editItem(item.copyWith(quantity: 2));
    expect(sut.totalItems, 1);
    expect(sut.total, 2.00);
  });

  test('Should edit an existent item at the same position', () async {
    final itemAtPosition1 = makeCartItem(quantity: 1, price: 1);

    final sut = CartEntity(
      user: makeUserEntity(),
      items: [makeCartItem(), itemAtPosition1, makeCartItem()],
    );

    expect(sut.totalItems, 3);
    expect(sut.items[1], itemAtPosition1);

    final changedItemAtPosition1 = itemAtPosition1.copyWith(quantity: 2);
    sut.editItem(changedItemAtPosition1);

    expect(sut.totalItems, 3);
    expect(sut.items[1], changedItemAtPosition1);
  });

  test('Should throw a CartItemDoesntExistsError if edit an inexistent item',
      () async {
    final sut = CartEntity(user: makeUserEntity(), items: [makeCartItem()]);

    expect(
      () => sut.editItem(makeCartItem()),
      throwsA(const TypeMatcher<CartItemDoesntExistsError>()),
    );
  });

  test('Should remove an existent item', () async {
    final item = makeCartItem(quantity: 1, price: 1);

    final sut = CartEntity(
      user: makeUserEntity(),
      items: [item],
    );

    sut.removeItem(item);

    expect(sut.totalItems, 0);
    expect(sut.total, 0.0);
  });

  test('Should throw a CartItemDoesntExistsError if remove an inexistent item',
      () async {
    final sut = CartEntity(user: makeUserEntity(), items: [makeCartItem()]);

    expect(
      () => sut.removeItem(makeCartItem()),
      throwsA(const TypeMatcher<CartItemDoesntExistsError>()),
    );
  });
}
