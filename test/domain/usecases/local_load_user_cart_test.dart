import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/user_entity_utils.dart';
import '../../utils/utils.dart';
import 'local_load_user_cart_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalLoadUserCart sut;
  late MockCacheStorage cacheStorageSpy;
  late CartEntity cart;
  late String userId;

  PostExpectation mockCacheCall() => when(cacheStorageSpy.fetch(any));

  mockCacheSuccess(dynamic data) {
    mockCacheCall().thenAnswer((_) async => data);
  }

  mockCacheError() {
    mockCacheCall().thenThrow(Exception());
  }

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalLoadUserCart(cacheStorage: cacheStorageSpy);

    cart = CartEntity(
      user: makeUserEntity(),
      items: [
        makeCartItem(),
        makeCartItem(),
      ],
    );

    userId = cart.user.id;

    mockCacheSuccess({
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
    });
  });

  test('Should call CacheStorage with correct data', () async {
    await sut.load(userId);

    verify(cacheStorageSpy.fetch('user_cart_$userId')).called(1);
  });

  test('Should return user cart data', () async {
    final data = await sut.load(userId);

    expect(data, cart);
  });

  test('Should return null if cache returns null ', () async {
    mockCacheSuccess(null);

    final data = await sut.load(userId);

    expect(data, isNull);
  });

  test('Should throw a LoadUserCartError if save fails', () async {
    mockCacheError();

    final future = sut.load(userId);

    expect(future, throwsA(const TypeMatcher<LoadUserCartError>()));
  });
}
