import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';

import '../data/cache/cache.dart';
import '../infra/cache/local_storage_adapter.dart';

Future<void> injectInfra() async {
  final localStorage = LocalStorage("grocery_store_app");
  await localStorage.ready;

  GetIt.I.registerSingleton<CacheStorage>(
    LocalStorageAdapter(localStorage: localStorage),
  );
}
