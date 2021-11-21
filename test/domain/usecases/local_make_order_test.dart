import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/utils.dart';
import 'local_make_order_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalMakeOrder sut;
  late MockCacheStorage cacheStorageSpy;
  late OrderEntity order;

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalMakeOrder(cacheStorage: cacheStorageSpy);

    order = makeOrder();
  });

  mockCacheError() {
    when(
      cacheStorageSpy.save(key: anyNamed('key'), value: anyNamed('value')),
    ).thenThrow(Exception());
  }

  test('Should call CacheStorage with correct values', () async {
    await sut.save(order);

    verify(
      cacheStorageSpy.save(
        key: 'order_user_${order.user.id}',
        value: {
          'id': order.id,
          'user': {
            'id': order.user.id,
            'name': order.user.name,
            'cpf': order.user.cpf,
            'address': {
              'id': order.user.mainAddress.id,
              'title': order.user.mainAddress.title,
              'street': order.user.mainAddress.street,
              'number': order.user.mainAddress.number,
              'city': order.user.mainAddress.city,
              'state': order.user.mainAddress.state,
              'country': order.user.mainAddress.country,
              'zipCode': order.user.mainAddress.zipCode,
              'additionalInfo': order.user.mainAddress.additionalInfo,
            },
          },
          'items': [
            {
              'id': order.items[0].id,
              'product': {
                'id': order.items[0].product.id,
                'imagePath': order.items[0].product.imagePath,
                'name': order.items[0].product.name,
                'unitType': order.items[0].product.unitType.name,
                'price': order.items[0].product.price,
              },
              'quantity': order.items[0].quantity,
            },
            {
              'id': order.items[1].id,
              'product': {
                'id': order.items[1].product.id,
                'imagePath': order.items[1].product.imagePath,
                'name': order.items[1].product.name,
                'unitType': order.items[1].product.unitType.name,
                'price': order.items[1].product.price,
              },
              'quantity': order.items[1].quantity,
            }
          ],
          'date': order.date.toIso8601String(),
          'address': {
            'id': order.user.mainAddress.id,
            'title': order.user.mainAddress.title,
            'street': order.user.mainAddress.street,
            'number': order.user.mainAddress.number,
            'city': order.user.mainAddress.city,
            'state': order.user.mainAddress.state,
            'country': order.user.mainAddress.country,
            'zipCode': order.user.mainAddress.zipCode,
            'additionalInfo': order.user.mainAddress.additionalInfo,
          },
        },
      ),
    ).called(1);
  });

  test('Should throw a MakeOrderError if save fails ', () async {
    mockCacheError();

    final future = sut.save(order);

    expect(future, throwsA(const TypeMatcher<MakeOrderError>()));
  });
}
