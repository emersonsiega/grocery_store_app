import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_save_user_account_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalSaveUserAccount sut;
  late MockCacheStorage cacheStorageSpy;
  late UserEntity userEntity;

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalSaveUserAccount(cacheStorage: cacheStorageSpy);

    userEntity = UserEntity(
      id: faker.guid.guid(),
      name: faker.person.name(),
      cpf: faker.randomGenerator.numberOfLength(11),
      mainAddress: AddressEntity(
        id: faker.guid.guid(),
        title: faker.lorem.word(),
        zipCode: faker.randomGenerator.numberOfLength(8),
        city: faker.lorem.sentence(),
        country: faker.lorem.word(),
        number: faker.randomGenerator.numberOfLength(3),
        state: faker.lorem.word(),
        street: faker.lorem.sentence(),
        additionalInfo: faker.lorem.sentence(),
      ),
    );
  });

  mockCacheError(Exception error) {
    when(
      cacheStorageSpy.save(key: anyNamed('key'), value: anyNamed('value')),
    ).thenThrow(error);
  }

  test('Should call CacheStorage with correct values', () async {
    await sut.save(userEntity);

    verify(
      cacheStorageSpy.save(key: 'user_account', value: anyNamed('value')),
    ).called(1);
  });

  test('Should throw SaveUserAccountError if cache fails', () async {
    mockCacheError(Exception());

    final future = sut.save(userEntity);

    expect(future, throwsA(const TypeMatcher<SaveUserAccountError>()));
  });
}
