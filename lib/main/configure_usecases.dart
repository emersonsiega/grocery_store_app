import 'package:get_it/get_it.dart';

import '../domain/domain.dart';

void injectUseCases() {
  GetIt.I.registerLazySingleton<UserAuthentication>(
    () => FakeUserAuthentication(),
  );

  GetIt.I.registerLazySingleton<LoadProducts>(
    () => LocalLoadProducts(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<LoadUserAccount>(
    () => LocalLoadUserAccount(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<SaveUserAccount>(
    () => LocalSaveUserAccount(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<LoadUserCart>(
    () => LocalLoadUserCart(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<SaveUserCart>(
    () => LocalSaveUserCart(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<MakeOrder>(
    () => LocalMakeOrder(cacheStorage: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<MakeOrderReceipt>(
    () => LocalMakeOrderReceipt(pdfMaker: GetIt.I.get()),
  );

  GetIt.I.registerLazySingleton<LoadUserOrders>(
    () => LocalLoadUserOrders(cacheStorage: GetIt.I.get()),
  );
}
