import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';
import 'address_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String name;
  final String cpf;
  final AddressModel address;

  const UserModel({
    required this.id,
    required this.name,
    required this.cpf,
    required this.address,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      cpf: entity.cpf,
      address: AddressModel.fromEntity(entity.mainAddress),
    );
  }

  @override
  List<Object?> get props => [id, name, cpf, address];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
