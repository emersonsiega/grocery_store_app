import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import 'settings/settings.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            ResponsiveConfig(designScreenWidth: 414, designScreenHeight: 736)
                .init(constraints, orientation);

            return MaterialApp.router(
              theme: AppTheme.theme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
            );
          },
        );
      },
    );
  }
}
