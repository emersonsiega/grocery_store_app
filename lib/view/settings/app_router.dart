import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: true,
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(
      page: AppPage,
      children: [
        AutoRoute(page: HomePage, initial: true),
        AutoRoute(page: CartPage),
        AutoRoute(page: UserAccountPage),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
