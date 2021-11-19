import '../domain.dart';

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

  bool _containsItem(CartItemEntity item) {
    final existentItem = items.where((cartItem) => cartItem.id == item.id);

    return existentItem.isNotEmpty;
  }

  int _itemIndex(CartItemEntity item) {
    return items.indexWhere((cartItem) => cartItem.id == item.id);
  }

  void addItem(CartItemEntity item) {
    if (_containsItem(item)) {
      throw CartItemAlreadyExistsError();
    }

    items.add(item);
  }

  void editItem(CartItemEntity item) {
    if (!_containsItem(item)) {
      throw CartItemDoesntExistsError();
    }

    int currentIndex = _itemIndex(item);
    items.replaceRange(currentIndex, currentIndex + 1, [item]);
  }

  void removeItem(CartItemEntity item) {
    if (!_containsItem(item)) {
      throw CartItemDoesntExistsError();
    }

    items.remove(item);
  }

  @override
  List<Object?> get props => [id, user, items];
}
