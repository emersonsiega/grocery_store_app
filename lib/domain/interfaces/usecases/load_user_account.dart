import '../../domain.dart';

abstract class LoadUserAccount {
  Future<UserEntity?> load();
}
