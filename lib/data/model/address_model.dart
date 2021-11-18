import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Equatable {
  final String id;
  final String title;
  final String street;
  final String number;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String? additionalInfo;

  const AddressModel({
    required this.id,
    required this.title,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.additionalInfo,
  });

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      title: entity.title,
      street: entity.street,
      number: entity.number,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      zipCode: entity.zipCode,
      additionalInfo: entity.additionalInfo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        street,
        number,
        city,
        state,
        country,
        zipCode,
        additionalInfo,
      ];

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
