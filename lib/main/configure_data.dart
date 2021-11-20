import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../data/cache/cache.dart';

Future<void> createProductsList() async {
  const key = 'product_list';
  final storage = GetIt.I.get<CacheStorage>();
  final productList = await storage.fetch(key);

  if (productList == null) {
    await storage.save(key: key, value: _products);
  }
}

List<Map<String, dynamic>> get _products => [
      {
        "id": const Uuid().v4(),
        "imagePath": "assets/images/products/apple.svg",
        "name": "Maçã",
        "unitType": "kg",
        "price": 3.95
      },
      {
        "id": const Uuid().v4(),
        "imagePath": "assets/images/products/banana.svg",
        "name": "Banana",
        "unitType": "kg",
        "price": 4.80
      },
      {
        "id": const Uuid().v4(),
        "imagePath": "assets/images/products/mango.svg",
        "name": "Manga",
        "unitType": "kg",
        "price": 2.90
      },
      {
        "id": const Uuid().v4(),
        "imagePath": "assets/images/products/peach.svg",
        "name": "Pêra",
        "unitType": "kg",
        "price": 5.00
      },
      {
        "id": const Uuid().v4(),
        "imagePath": "assets/images/products/pineapple.svg",
        "name": "Abacaxi",
        "unitType": "unit",
        "price": 3.50
      }
    ];
