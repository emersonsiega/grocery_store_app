import 'package:flutter/foundation.dart';

import '../domain.dart';

enum ProductUnitType { unit, kg }

extension ProductUnitTypeString on ProductUnitType {
  String get name => describeEnum(this);
}

class ProductEntity extends BaseEntity {
  final String imagePath;
  final String name;
  final ProductUnitType unitType;
  final double price;

  ProductEntity({
    String? id,
    required this.imagePath,
    required this.name,
    required this.unitType,
    required this.price,
  }) : super(id);

  @override
  List<Object?> get props => [
        id,
        imagePath,
        name,
        unitType,
        price,
      ];
}
