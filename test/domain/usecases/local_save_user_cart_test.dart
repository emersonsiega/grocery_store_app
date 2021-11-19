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
      'userId': cart.user.id,
      'items': [
        {
          'id': cart.items[0].id,
          'productId': cart.items[0].product.id,
          'quantity': cart.items[0].quantity,
        },
        {
          'id': cart.items[1].id,
          'productId': cart.items[1].product.id,
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
