import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';

import '../data/cache/cache.dart';
import '../infra/cache/local_storage_adapter.dart';

void injectInfra() {
  GetIt.I.registerLazySingleton<CacheStorage>(
    () => LocalStorageAdapter(
      localStorage: LocalStorage("grocery_store_app"),
    ),
  );
}
