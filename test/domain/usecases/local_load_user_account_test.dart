import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/user_entity_utils.dart';
import 'local_load_user_account_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalLoadUserAccount sut;
  late MockCacheStorage cacheStorageSpy;
  late UserEntity user;

  PostExpectation mockCacheCall() => when(cacheStorageSpy.fetch(any));

  void mockCacheSuccess(dynamic value) {
    mockCacheCall().thenAnswer((_) async => value);
  }

  void mockCacheError() {
    mockCacheCall().thenAnswer((_) async => Exception());
  }

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalLoadUserAccount(cacheStorage: cacheStorageSpy);

    user = makeUserEntity();

    mockCacheSuccess({
      'id': user.id,
      'cpf': user.cpf,
      'name': user.name,
      'address': {
        'id': user.mainAddress.id,
        'city': user.mainAddress.city,
        'number': user.mainAddress.number,
        'country': user.mainAddress.country,
        'state': user.mainAddress.state,
        'street': user.mainAddress.street,
        'title': user.mainAddress.title,
        'zipCode': user.mainAddress.zipCode,
        'additionalInfo': user.mainAddress.additionalInfo,
      },
    });
  });

  test('Should call to cacheStorage with correct values', () async {
    await sut.load();

    verify(cacheStorageSpy.fetch('user_account')).called(1);
  });

  test('Should return a UserEntity', () async {
    final response = await sut.load();

    expect(response, user);
  });

  test('Should throw a LoadUserAccountError if load fails', () async {
    mockCacheError();

    final future = sut.load();

    expect(future, throwsA(const TypeMatcher<LoadUserAccountError>()));
  });
}
