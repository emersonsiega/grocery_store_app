import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String id;
  final String imagePath;
  final String name;
  final String unitType;
  final double price;

  const ProductModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.unitType,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        imagePath,
        name,
        unitType,
        price,
      ];

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() {
    final unit = ProductUnitType.values.firstWhere(
      (item) => item.name == unitType,
    );

    return ProductEntity(
      id: id,
      imagePath: imagePath,
      name: name,
      unitType: unit,
      price: price,
    );
  }
}
