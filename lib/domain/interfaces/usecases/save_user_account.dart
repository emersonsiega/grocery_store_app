import '../../domain.dart';

abstract class SaveUserAccount {
  Future<void> save(UserEntity entity);
}
