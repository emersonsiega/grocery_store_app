import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';

void main() {
  late FakeUserAuthentication sut;
  late String username;
  late String password;

  setUp(() {
    username = faker.internet.userName();
    password = faker.internet.password();
    sut = FakeUserAuthentication();
  });

  test('Should accept any credentials', () async {
    var response = await sut.authenticate(
      username: username,
      password: password,
    );

    expect(response, isNotNull);

    response = await sut.authenticate(
      username: 'any',
      password: 'any',
    );

    expect(response, isNotNull);
  });

  test('Should return an UserEntity if authenticate without errors', () async {
    final response = await sut.authenticate(
      username: username,
      password: password,
    );

    expect(response.name, isNotNull);
    expect(response.mainAddress, isNotNull);
  });

  test('Should thrown an InvalidCredentialsError if creadentials are empty',
      () async {
    var future = sut.authenticate(
      username: '',
      password: password,
    );

    expect(future, throwsA(const TypeMatcher<InvalidCredentialsError>()));

    future = sut.authenticate(
      username: username,
      password: '',
    );

    expect(future, throwsA(const TypeMatcher<InvalidCredentialsError>()));
  });
}
