import 'package:get_it/get_it.dart';

import '../domain/domain.dart';

void injectUseCases() {
  GetIt.I.registerLazySingleton<UserAuthentication>(
    () => FakeUserAuthentication(),
  );

  GetIt.I.registerLazySingleton<SaveUserAccount>(
    () => LocalSaveUserAccount(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<LoadProducts>(
    () => LocalLoadProducts(cacheStorage: GetIt.I.get()),
  );
}
