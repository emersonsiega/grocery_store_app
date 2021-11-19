import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends Equatable {
  final String id;
  final String productId;
  final double quantity;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      productId: entity.product.id,
      quantity: entity.quantity,
    );
  }

  @override
  List<Object?> get props => [id, productId, quantity];

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
