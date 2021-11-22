import 'package:intl/date_symbol_data_local.dart';

import 'configure_data.dart';
import 'configure_infra.dart';
import 'configure_presenters.dart';
import 'configure_usecases.dart';

Future<void> configureApp() async {
  await injectInfra();

  injectData();

  injectUseCases();

  injectPresenters();

  await createProductsList();

  await initializeDateFormatting('pt_BR', null);
}
