import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:grocery_store_app/presentation/presentation.dart';
import 'package:grocery_store_app/view/view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/utils.dart';
import 'cubit_login_presenter_test.mocks.dart';

@GenerateMocks([UserAuthentication, SaveUserAccount])
void main() {
  late CubitLoginPresenter sut;
  late MockUserAuthentication userAuthenticationSpy;
  late MockSaveUserAccount saveUserAccountSpy;
  late String username;
  late String password;
  late UserEntity userEntity;

  PostExpectation mockAuthenticationCall() =>
      when(userAuthenticationSpy.authenticate(
          username: anyNamed('username'), password: anyNamed('password')));

  void mockAuthenticationSuccess(UserEntity userEntity) {
    mockAuthenticationCall().thenAnswer((_) async => userEntity);
  }

  void mockAuthenticationError() {
    mockAuthenticationCall().thenThrow(InvalidCredentialsError());
  }

  void mockSaveUserAccountError() {
    when(saveUserAccountSpy.save(any)).thenThrow(SaveUserAccountError());
  }

  setUp(() {
    userAuthenticationSpy = MockUserAuthentication();
    saveUserAccountSpy = MockSaveUserAccount();
    sut = CubitLoginPresenter(
      userAuthentication: userAuthenticationSpy,
      saveUserAccount: saveUserAccountSpy,
    );

    username = faker.internet.userName();
    password = faker.internet.password();

    userEntity = makeUserEntity(name: username);

    mockAuthenticationSuccess(userEntity);
  });

  test('Should emit correct events when authenticate', () async {
    expectLater(
      sut.stream,
      emitsInOrder(const [
        LoginState(isLoading: true),
        LoginState(isLoading: false, completed: true),
      ]),
    );

    await sut.authenticate(user: username, password: password);
  });

  test('Should call to UserAuthentication with correct values when submit',
      () async {
    await sut.authenticate(user: username, password: password);

    verify(
      userAuthenticationSpy.authenticate(
          username: username, password: password),
    ).called(1);
  });

  test('Should call to SaveUserAccount when UserAuthentication completes',
      () async {
    await sut.authenticate(user: username, password: password);

    verify(saveUserAccountSpy.save(userEntity)).called(1);
  });

  test(
      'Should show an error message if UserAuthentication throws InvalidCredentialsError',
      () async {
    mockAuthenticationError();

    expectLater(
      sut.stream,
      emitsInOrder(const [
        LoginState(isLoading: true),
        LoginState(
          isLoading: false,
          completed: false,
          errorMessage: 'Usuário ou senha inválidos',
        ),
      ]),
    );

    await sut.authenticate(user: username, password: password);
  });

  test(
      'Should show an error message if SaveUserAccount throws SaveUserAccountError',
      () async {
    mockSaveUserAccountError();

    expectLater(
      sut.stream,
      emitsInOrder(const [
        LoginState(isLoading: true),
        LoginState(
          isLoading: false,
          completed: false,
          errorMessage: 'Não foi possível completar login... Tente novamente',
        ),
      ]),
    );

    await sut.authenticate(user: username, password: password);
  });
}
