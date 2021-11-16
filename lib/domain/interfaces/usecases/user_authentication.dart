import '../../domain.dart';

abstract class UserAuthentication {
  Future<UserEntity> authenticate({
    required String username,
    required String password,
  });
}
