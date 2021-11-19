import 'package:get_it/get_it.dart';

import '../presentation/presentation.dart';
import '../view/view.dart';

void injectPresenters() {
  GetIt.I.registerLazySingleton<LoginPresenter>(
    () => CubitLoginPresenter(
      saveUserAccount: GetIt.I.get(),
      userAuthentication: GetIt.I.get(),
    ),
  );
}
