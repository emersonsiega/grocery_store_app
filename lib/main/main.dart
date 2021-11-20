import 'configure_data.dart';
import 'configure_infra.dart';
import 'configure_presenters.dart';
import 'configure_usecases.dart';

Future<void> configureApp() async {
  await injectInfra();

  injectUseCases();

  injectPresenters();

  await createProductsList();
}
