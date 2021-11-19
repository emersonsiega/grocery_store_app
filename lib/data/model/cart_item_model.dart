import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';
import '../data.dart';

part 'cart_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItemModel extends Equatable {
  final String id;
  final ProductModel product;
  final double quantity;

  const CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      product: ProductModel.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
