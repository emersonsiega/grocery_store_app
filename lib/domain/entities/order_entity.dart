import '../domain.dart';

class OrderEntity extends BaseEntity {
  final UserEntity user;
  final List<CartItemEntity> items;
  final DateTime date;
  final AddressEntity address;

  OrderEntity({
    String? id,
    required this.user,
    required this.items,
    required this.date,
    required this.address,
  }) : super(id);

  factory OrderEntity.fromCart(CartEntity entity) {
    return OrderEntity(
      user: entity.user,
      items: entity.items,
      date: DateTime.now(),
      address: entity.user.mainAddress,
    );
  }

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

  @override
  List<Object?> get props => [id, user, items, date, address];
}
