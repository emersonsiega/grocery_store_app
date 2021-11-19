import 'configure_usecases.dart';
import 'configure_infra.dart';
import 'configure_presenters.dart';

void configureApp() {
  injectInfra();

  injectUseCases();

  injectPresenters();
}
