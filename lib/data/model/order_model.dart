import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';
import '../data.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel extends Equatable {
  final String id;
  final UserModel user;
  final List<CartItemModel> items;
  final DateTime date;
  final AddressModel address;

  const OrderModel({
    required this.id,
    required this.user,
    required this.items,
    required this.date,
    required this.address,
  });

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      items: entity.items.map((e) => CartItemModel.fromEntity(e)).toList(),
      date: entity.date,
      user: UserModel.fromEntity(entity.user),
      address: AddressModel.fromEntity(entity.address),
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      user: user.toEntity(),
      items: items.map((e) => e.toEntity()).toList(),
      date: date,
      address: address.toEntity(),
    );
  }

  @override
  List<Object?> get props => [id, items, user, date, address];

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
