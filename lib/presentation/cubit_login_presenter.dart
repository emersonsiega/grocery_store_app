import 'package:bloc/bloc.dart';

import '../domain/domain.dart';
import '../view/view.dart';

class CubitLoginPresenter extends Cubit<LoginState> implements LoginPresenter {
  final UserAuthentication userAuthentication;
  final SaveUserAccount saveUserAccount;
  static const _invalidCredentialsMessage = "Usuário ou senha inválidos";
  static const _userAccountErrorMessage =
      "Não foi possível completar login... Tente novamente";

  CubitLoginPresenter({
    required this.userAuthentication,
    required this.saveUserAccount,
  }) : super(const LoginState());

  @override
  Future<void> authenticate({
    required String user,
    required String password,
  }) async {
    try {
      emit(const LoginState(isLoading: true));

      final entity = await userAuthentication.authenticate(
        username: user,
        password: password,
      );

      await saveUserAccount.save(entity);

      emit(const LoginState(completed: true));
    } on InvalidCredentialsError {
      emit(const LoginState(errorMessage: _invalidCredentialsMessage));
    } on SaveUserAccountError {
      emit(const LoginState(errorMessage: _userAccountErrorMessage));
    }
  }
}
