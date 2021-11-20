import '../view.dart';

abstract class LoginPresenter extends BasePresenter<LoginState> {
  Future<void> authenticate({
    required String user,
    required String password,
  });
}
