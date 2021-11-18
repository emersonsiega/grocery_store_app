import '../../data/cache/cache.dart';
import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalSaveUserAccount implements SaveUserAccount {
  static const String _userAccountKey = "user_account";
  final CacheStorage cacheStorage;

  LocalSaveUserAccount({required this.cacheStorage});

  @override
  Future<void> save(UserEntity entity) async {
    try {
      final json = UserModel.fromEntity(entity).toJson();
      cacheStorage.save(key: _userAccountKey, value: json);
    } catch (error, trace) {
      Log.e("Save user account error", data: error, trace: trace);
      throw SaveUserAccountError();
    }
  }
}
