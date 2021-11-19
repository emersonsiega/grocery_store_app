import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';
import '../data.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel extends Equatable {
  final String id;
  final UserModel user;
  final List<CartItemModel> items;

  const CartModel({
    required this.id,
    required this.user,
    required this.items,
  });

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      id: entity.id,
      user: UserModel.fromEntity(entity.user),
      items: entity.items.map((e) => CartItemModel.fromEntity(e)).toList(),
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      user: user.toEntity(),
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, user, items];

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
