import 'package:copy_with_extension/copy_with_extension.dart';

import '../domain.dart';

part 'cart_entity.g.dart';

@CopyWith()
class CartEntity extends BaseEntity {
  final UserEntity user;
  final List<CartItemEntity> items;

  CartEntity({
    String? id,
    required this.user,
    required this.items,
  }) : super(id);

  int get totalItems => items.length;

  double get total {
    if (items.isEmpty) {
      return 0.0;
    }

    return double.parse(
      items
          .map((item) => item.total)
          .reduce((acc, total) => acc + total)
          .toStringAsFixed(2),
    );
  }

  bool containsProduct(ProductEntity product) {
    final existentItem =
        items.where((cartItem) => cartItem.product.id == product.id);

    return existentItem.isNotEmpty;
  }

  bool _containsItem(CartItemEntity item) {
    final existentItem = items.where((cartItem) => cartItem.id == item.id);

    return existentItem.isNotEmpty;
  }

  List<CartItemEntity>? addItem(CartItemEntity item) {
    if (_containsItem(item)) {
      throw CartItemAlreadyExistsError();
    }

    return [...items, item];
  }

  List<CartItemEntity>? editItem(CartItemEntity item) {
    if (!_containsItem(item)) {
      throw CartItemDoesntExistsError();
    }

    return items.map((i) => i.id == item.id ? item : i).toList();
  }

  List<CartItemEntity>? removeItem(CartItemEntity item) {
    if (!_containsItem(item)) {
      throw CartItemDoesntExistsError();
    }

    final list = items.where((element) => element.id != item.id).toList();
    return list;
  }

  @override
  List<Object?> get props => [id, user, items];
}
