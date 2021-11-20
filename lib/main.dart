import 'package:flutter/material.dart';

import 'main/main.dart';
import 'view/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureApp();

  runApp(App());
}
