// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const LoginPage());
    },
    AppRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AppPage());
    },
    HomeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    CartRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const CartPage());
    },
    UserAccountRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const UserAccountPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(LoginRoute.name, path: '/'),
        RouteConfig(AppRoute.name, path: '/app-page', children: [
          RouteConfig(HomeRoute.name, path: '', parent: AppRoute.name),
          RouteConfig(CartRoute.name, path: 'cart-page', parent: AppRoute.name),
          RouteConfig(UserAccountRoute.name,
              path: 'user-account-page', parent: AppRoute.name)
        ])
      ];
}

/// generated route for [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/');

  static const String name = 'LoginRoute';
}

/// generated route for [AppPage]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
      : super(name, path: '/app-page', initialChildren: children);

  static const String name = 'AppRoute';
}

/// generated route for [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute() : super(name, path: 'cart-page');

  static const String name = 'CartRoute';
}

/// generated route for [UserAccountPage]
class UserAccountRoute extends PageRouteInfo<void> {
  const UserAccountRoute() : super(name, path: 'user-account-page');

  static const String name = 'UserAccountRoute';
}
