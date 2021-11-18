import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/cache/cache.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/utils.dart';
import 'local_save_user_account_test.mocks.dart';

@GenerateMocks([CacheStorage])
void main() {
  late LocalSaveUserAccount sut;
  late MockCacheStorage cacheStorageSpy;
  late UserEntity userEntity;

  setUp(() {
    cacheStorageSpy = MockCacheStorage();
    sut = LocalSaveUserAccount(cacheStorage: cacheStorageSpy);

    userEntity = makeUserEntity();
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
