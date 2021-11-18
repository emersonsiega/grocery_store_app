// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as String,
      title: json['title'] as String,
      street: json['street'] as String,
      number: json['number'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
      additionalInfo: json['additionalInfo'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'street': instance.street,
      'number': instance.number,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zipCode': instance.zipCode,
      'additionalInfo': instance.additionalInfo,
    };
