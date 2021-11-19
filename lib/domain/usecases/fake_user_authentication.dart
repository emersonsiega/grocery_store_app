import '../domain.dart';

class FakeUserAuthentication implements UserAuthentication {
  @override
  Future<UserEntity> authenticate({
    required String username,
    required String password,
  }) async {
    if (username.length < 2 || password.length < 2) {
      throw InvalidCredentialsError();
    }

    return UserEntity(
      name: username,
      cpf: '08685493048',
      mainAddress: AddressEntity(
        title: "Apartamento",
        country: "BR",
        number: "1112",
        city: "Ponta Grossa",
        state: "PR",
        street: "Av. União Panamericana",
        zipCode: "84045310",
        additionalInfo: "Apto 404, Torre 9",
      ),
    );
  }
}
