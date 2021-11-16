import 'package:faker/faker.dart';
import 'package:grocery_store_app/infra/infra.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'local_storage_adapter_test.mocks.dart';

@GenerateMocks([LocalStorage])
void main() {
  late String key;
  late dynamic value;
  late MockLocalStorage localStorageSpy;
  late LocalStorageAdapter sut;

  void mockDeleteError() {
    when(localStorageSpy.deleteItem(any)).thenThrow(Exception());
  }

  void mockSaveError() {
    when(localStorageSpy.setItem(any, any)).thenThrow(Exception());
  }

  setUp(() {
    key = faker.guid.guid();
    value = faker.lorem.sentence();
    localStorageSpy = MockLocalStorage();

    sut = LocalStorageAdapter(
      localStorage: localStorageSpy,
    );
  });

  group('save', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.save(key: key, value: value);

      verify(localStorageSpy.deleteItem(key)).called(1);
      verify(localStorageSpy.setItem(key, value)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      mockDeleteError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });

    test('Should throw if setItem throws', () async {
      mockSaveError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.delete(key);

      verify(localStorageSpy.deleteItem(key)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      mockDeleteError();

      final future = sut.delete(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetch', () {
    late String result;

    PostExpectation mockFetchCall() => when(localStorageSpy.getItem(any));

    void mockFetch() {
      result = faker.lorem.sentence();
      mockFetchCall().thenAnswer((_) async => result);
    }

    void mockFetchError() {
      mockFetchCall().thenThrow(Exception());
    }

    setUp(() {
      result = 'any_value';
      mockFetch();
    });

    test('Should call LocalStorage with correct value', () async {
      await sut.fetch(key);

      verify(localStorageSpy.getItem(key)).called(1);
    });

    test('Should return same value as localStorage', () async {
      final data = await sut.fetch(key);

      expect(data, result);
    });

    test('Should throw if getItem throws', () async {
      mockFetchError();

      final future = sut.fetch(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
