// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      unitType: json['unitType'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'name': instance.name,
      'unitType': instance.unitType,
      'price': instance.price,
    };
