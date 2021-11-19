import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_load_products_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalLoadProducts sut;
  late MockCacheStorage cacheStorageSpy;
  late ProductEntity productEntity1;
  late ProductEntity productEntity2;

  PostExpectation mockCacheCall() => when(cacheStorageSpy.fetch(any));

  void mockCacheSuccess(dynamic value) {
    mockCacheCall().thenAnswer((_) async => value);
  }

  void mockCacheError() {
    mockCacheCall().thenAnswer((_) async => Exception());
  }

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalLoadProducts(cacheStorage: cacheStorageSpy);

    productEntity1 = ProductEntity(
      imagePath: faker.internet.httpUrl(),
      name: faker.lorem.word(),
      unitType: ProductUnitType.unit,
      price: faker.randomGenerator.decimal(min: 0.01),
    );

    productEntity2 = ProductEntity(
      imagePath: faker.internet.httpUrl(),
      name: faker.lorem.word(),
      unitType: ProductUnitType.kg,
      price: faker.randomGenerator.decimal(min: 0.01),
    );

    mockCacheSuccess(
      [
        {
          'id': productEntity1.id,
          'imagePath': productEntity1.imagePath,
          'name': productEntity1.name,
          'unitType': productEntity1.unitType.name,
          'price': productEntity1.price,
        },
        {
          'id': productEntity2.id,
          'imagePath': productEntity2.imagePath,
          'name': productEntity2.name,
          'unitType': productEntity2.unitType.name,
          'price': productEntity2.price,
        }
      ],
    );
  });

  test('Should call to cacheStorage with correct values', () async {
    await sut.load();

    verify(cacheStorageSpy.fetch('product_list')).called(1);
  });

  test('Should return a list of ProductEntity', () async {
    final response = await sut.load();

    expect(response, [productEntity1, productEntity2]);
  });

  test('Should throw a LoadProductsError if load fails', () async {
    mockCacheError();

    final future = sut.load();

    expect(future, throwsA(const TypeMatcher<LoadProductsError>()));
  });
}
