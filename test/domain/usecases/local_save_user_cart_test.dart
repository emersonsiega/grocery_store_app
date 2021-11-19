import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/user_entity_utils.dart';
import '../../utils/utils.dart';
import 'local_save_user_cart_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalSaveUserCart sut;
  late MockCacheStorage cacheStorageSpy;
  late CartEntity cart;

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalSaveUserCart(cacheStorage: cacheStorageSpy);

    cart = CartEntity(
      user: makeUserEntity(),
      items: [
        makeCartItem(),
        makeCartItem(),
      ],
    );
  });

  mockCacheError() {
    when(
      cacheStorageSpy.save(key: anyNamed('key'), value: anyNamed('value')),
    ).thenThrow(Exception());
  }

  test('Should call CacheStorage with correct data', () async {
    await sut.save(cart);

    verify(cacheStorageSpy.save(key: 'user_cart_${cart.user.id}', value: {
      'id': cart.id,
      'user': {
        'id': cart.user.id,
        'cpf': cart.user.cpf,
        'name': cart.user.name,
        'address': {
          'id': cart.user.mainAddress.id,
          'city': cart.user.mainAddress.city,
          'number': cart.user.mainAddress.number,
          'country': cart.user.mainAddress.country,
          'state': cart.user.mainAddress.state,
          'street': cart.user.mainAddress.street,
          'title': cart.user.mainAddress.title,
          'zipCode': cart.user.mainAddress.zipCode,
          'additionalInfo': cart.user.mainAddress.additionalInfo,
        },
      },
      'items': [
        {
          'id': cart.items[0].id,
          'product': {
            'id': cart.items[0].product.id,
            'imagePath': cart.items[0].product.imagePath,
            'name': cart.items[0].product.name,
            'unitType': cart.items[0].product.unitType.name,
            'price': cart.items[0].product.price,
          },
          'quantity': cart.items[0].quantity,
        },
        {
          'id': cart.items[1].id,
          'product': {
            'id': cart.items[1].product.id,
            'imagePath': cart.items[1].product.imagePath,
            'name': cart.items[1].product.name,
            'unitType': cart.items[1].product.unitType.name,
            'price': cart.items[1].product.price,
          },
          'quantity': cart.items[1].quantity,
        }
      ],
    })).called(1);
  });

  test('Should throw a SaveUserCartError if save fails', () async {
    mockCacheError();
    final future = sut.save(cart);

    expect(future, throwsA(const TypeMatcher<SaveUserCartError>()));
  });
}
