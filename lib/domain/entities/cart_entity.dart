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

  int _itemIndex(CartItemEntity item) {
    return items.indexWhere((cartItem) => cartItem.id == item.id);
  }

  List<CartItemEntity>? addItem(CartItemEntity item) {
    if (_containsItem(item)) {
      throw CartItemAlreadyExistsError();
    }

    return [...items, item];
  }

  void editItem(CartItemEntity item) {
    if (!_containsItem(item)) {
      throw CartItemDoesntExistsError();
    }

    int currentIndex = _itemIndex(item);
    items.replaceRange(currentIndex, currentIndex + 1, [item]);
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
