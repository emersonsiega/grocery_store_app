import 'package:get_it/get_it.dart';

import '../presentation/presentation.dart';
import '../view/view.dart';

void injectPresenters() {
  GetIt.I.registerLazySingleton<AppPresenter>(
    () => CubitAppPresenter(
      loadProducts: GetIt.I.get(),
      loadUserAccount: GetIt.I.get(),
      loadUserCart: GetIt.I.get(),
    ),
  );

  GetIt.I.registerLazySingleton<LoginPresenter>(
    () => CubitLoginPresenter(
      saveUserAccount: GetIt.I.get(),
      userAuthentication: GetIt.I.get(),
    ),
  );

  GetIt.I.registerLazySingleton<HomePresenter>(
    () => CubitHomePresenter(
      appPresenter: GetIt.I.get(),
      saveUserCart: GetIt.I.get(),
    ),
  );

  GetIt.I.registerLazySingleton<CartPresenter>(
    () => CubitCartPresenter(
      appPresenter: GetIt.I.get(),
      saveUserCart: GetIt.I.get(),
      pdfMaker: GetIt.I.get(),
      makeUserOrder: GetIt.I.get(),
    ),
  );
}
