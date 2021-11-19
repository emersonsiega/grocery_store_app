import '../domain.dart';

class CartItemEntity extends BaseEntity {
  final ProductEntity product;

  final double quantity;

  CartItemEntity({
    String? id,
    required this.product,
    required this.quantity,
  }) : super(id);

  CartItemEntity copyWith({
    required double quantity,
  }) {
    return CartItemEntity(
      id: id,
      product: product,
      quantity: quantity,
    );
  }

  double get total {
    return double.parse((product.price * quantity).toStringAsFixed(2));
  }

  @override
  List<Object?> get props => [id, product, quantity];
}
