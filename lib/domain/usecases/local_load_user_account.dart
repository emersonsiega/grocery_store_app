import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalLoadUserAccount implements LoadUserAccount {
  final CacheStorage cacheStorage;
  static const String _userAccountKey = "user_account";

  LocalLoadUserAccount({
    required this.cacheStorage,
  });

  @override
  Future<UserEntity?> load() async {
    try {
      final user = await cacheStorage.fetch(_userAccountKey);

      if (user == null) {
        return null;
      }

      return UserModel.fromJson(user).toEntity();
    } catch (error, trace) {
      Log.e("Load user account error", data: error, trace: trace);
      throw LoadUserAccountError();
    }
  }
}
