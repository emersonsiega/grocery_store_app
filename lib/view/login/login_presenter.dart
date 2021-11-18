import '../view.dart';

abstract class LoginPresenter {
  Stream<LoginState> get stream;

  Future<void> authenticate({required String user, required String password});
}
