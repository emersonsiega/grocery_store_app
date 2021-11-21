// Mocks generated by Mockito 5.0.16 from annotations
// in grocery_store_app/test/utils/load_page_utils.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:ui' as _i10;

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:auto_route/src/matcher/route_matcher.dart' as _i5;
import 'package:auto_route/src/navigation_failure.dart' as _i9;
import 'package:auto_route/src/route/page_route_info.dart' as _i8;
import 'package:auto_route/src/router/controller/pageless_routes_observer.dart'
    as _i3;
import 'package:flutter/foundation.dart' as _i2;
import 'package:flutter/material.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeLocalKey_0 extends _i1.Fake implements _i2.LocalKey {}

class _FakePagelessRoutesObserver_1 extends _i1.Fake
    implements _i3.PagelessRoutesObserver {}

class _FakeGlobalKey_2<T extends _i4.State<_i4.StatefulWidget>> extends _i1.Fake
    implements _i4.GlobalKey<T> {}

class _FakeRouteCollection_3 extends _i1.Fake implements _i5.RouteCollection {}

class _FakeAutoRoutePage_4<T> extends _i1.Fake implements _i6.AutoRoutePage<T> {
}

class _FakeRouteMatcher_5 extends _i1.Fake implements _i5.RouteMatcher {}

class _FakeRouteData_6 extends _i1.Fake implements _i6.RouteData {}

class _FakeNavigationHistory_7 extends _i1.Fake
    implements _i6.NavigationHistory {}

class _FakeStackRouter_8 extends _i1.Fake implements _i6.StackRouter {}

class _FakeRouteMatch_9<T> extends _i1.Fake implements _i6.RouteMatch<T> {}

class _FakeRoutingController_10 extends _i1.Fake
    implements _i6.RoutingController {}

/// A class which mocks [StackRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockStackRouter extends _i1.Mock implements _i6.StackRouter {
  MockStackRouter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LocalKey get key => (super.noSuchMethod(Invocation.getter(#key),
      returnValue: _FakeLocalKey_0()) as _i2.LocalKey);
  @override
  _i3.PagelessRoutesObserver get pagelessRoutesObserver =>
      (super.noSuchMethod(Invocation.getter(#pagelessRoutesObserver),
              returnValue: _FakePagelessRoutesObserver_1())
          as _i3.PagelessRoutesObserver);
  @override
  int get stateHash =>
      (super.noSuchMethod(Invocation.getter(#stateHash), returnValue: 0)
          as int);
  @override
  _i4.GlobalKey<_i4.NavigatorState> get navigatorKey =>
      (super.noSuchMethod(Invocation.getter(#navigatorKey),
              returnValue: _FakeGlobalKey_2<_i4.NavigatorState>())
          as _i4.GlobalKey<_i4.NavigatorState>);
  @override
  _i5.RouteCollection get routeCollection =>
      (super.noSuchMethod(Invocation.getter(#routeCollection),
          returnValue: _FakeRouteCollection_3()) as _i5.RouteCollection);
  @override
  _i6.PageBuilder get pageBuilder => (super.noSuchMethod(
          Invocation.getter(#pageBuilder),
          returnValue: (_i6.RouteData data) => _FakeAutoRoutePage_4<dynamic>())
      as _i6.PageBuilder);
  @override
  _i5.RouteMatcher get matcher =>
      (super.noSuchMethod(Invocation.getter(#matcher),
          returnValue: _FakeRouteMatcher_5()) as _i5.RouteMatcher);
  @override
  bool get canPopSelfOrChildren =>
      (super.noSuchMethod(Invocation.getter(#canPopSelfOrChildren),
          returnValue: false) as bool);
  @override
  _i6.RouteData get current => (super.noSuchMethod(Invocation.getter(#current),
      returnValue: _FakeRouteData_6()) as _i6.RouteData);
  @override
  _i6.RouteData get topRoute =>
      (super.noSuchMethod(Invocation.getter(#topRoute),
          returnValue: _FakeRouteData_6()) as _i6.RouteData);
  @override
  bool get hasPagelessTopRoute =>
      (super.noSuchMethod(Invocation.getter(#hasPagelessTopRoute),
          returnValue: false) as bool);
  @override
  List<_i6.AutoRoutePage<dynamic>> get stack =>
      (super.noSuchMethod(Invocation.getter(#stack),
              returnValue: <_i6.AutoRoutePage<dynamic>>[])
          as List<_i6.AutoRoutePage<dynamic>>);
  @override
  bool get hasEntries =>
      (super.noSuchMethod(Invocation.getter(#hasEntries), returnValue: false)
          as bool);
  @override
  Map<_i2.LocalKey, _i6.RoutingController> get childControllers =>
      (super.noSuchMethod(Invocation.getter(#childControllers),
              returnValue: <_i2.LocalKey, _i6.RoutingController>{})
          as Map<_i2.LocalKey, _i6.RoutingController>);
  @override
  _i6.NavigationHistory get navigationHistory =>
      (super.noSuchMethod(Invocation.getter(#navigationHistory),
          returnValue: _FakeNavigationHistory_7()) as _i6.NavigationHistory);
  @override
  List<_i6.RouteData> get stackData =>
      (super.noSuchMethod(Invocation.getter(#stackData),
          returnValue: <_i6.RouteData>[]) as List<_i6.RouteData>);
  @override
  bool get managedByWidget => (super
          .noSuchMethod(Invocation.getter(#managedByWidget), returnValue: false)
      as bool);
  @override
  bool get isTopMost =>
      (super.noSuchMethod(Invocation.getter(#isTopMost), returnValue: false)
          as bool);
  @override
  bool get canNavigateBack => (super
          .noSuchMethod(Invocation.getter(#canNavigateBack), returnValue: false)
      as bool);
  @override
  _i6.StackRouter get root => (super.noSuchMethod(Invocation.getter(#root),
      returnValue: _FakeStackRouter_8()) as _i6.StackRouter);
  @override
  bool get isRoot =>
      (super.noSuchMethod(Invocation.getter(#isRoot), returnValue: false)
          as bool);
  @override
  _i6.RouteMatch<dynamic> get topMatch => (super.noSuchMethod(
      Invocation.getter(#topMatch),
      returnValue: _FakeRouteMatch_9<dynamic>()) as _i6.RouteMatch<dynamic>);
  @override
  _i6.RouteData get routeData =>
      (super.noSuchMethod(Invocation.getter(#routeData),
          returnValue: _FakeRouteData_6()) as _i6.RouteData);
  @override
  List<_i6.RouteMatch<dynamic>> get currentSegments =>
      (super.noSuchMethod(Invocation.getter(#currentSegments),
              returnValue: <_i6.RouteMatch<dynamic>>[])
          as List<_i6.RouteMatch<dynamic>>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<T?> pushWidget<T extends Object?>(_i4.Widget? widget,
          {_i4.RouteTransitionsBuilder? transitionBuilder,
          bool? fullscreenDialog = false,
          Duration? transitionDuration = const Duration(milliseconds: 300)}) =>
      (super.noSuchMethod(
          Invocation.method(#pushWidget, [
            widget
          ], {
            #transitionBuilder: transitionBuilder,
            #fullscreenDialog: fullscreenDialog,
            #transitionDuration: transitionDuration
          }),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i7.Future<T?> pushNativeRoute<T extends Object?>(_i4.Route<T>? route) =>
      (super.noSuchMethod(Invocation.method(#pushNativeRoute, [route]),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i6.RoutingController topMostRouter({bool? ignorePagelessRoutes = false}) =>
      (super.noSuchMethod(
          Invocation.method(#topMostRouter, [],
              {#ignorePagelessRoutes: ignorePagelessRoutes}),
          returnValue: _FakeRoutingController_10()) as _i6.RoutingController);
  @override
  _i7.Future<bool> pop<T extends Object?>([T? result]) =>
      (super.noSuchMethod(Invocation.method(#pop, [result]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  void popForced<T extends Object?>([T? result]) =>
      super.noSuchMethod(Invocation.method(#popForced, [result]),
          returnValueForMissingStub: null);
  @override
  bool removeLast() => (super.noSuchMethod(Invocation.method(#removeLast, []),
      returnValue: false) as bool);
  @override
  void removeRoute(_i6.RouteData? route, {bool? notify = true}) => super
      .noSuchMethod(Invocation.method(#removeRoute, [route], {#notify: notify}),
          returnValueForMissingStub: null);
  @override
  _i7.Future<T?> push<T extends Object?>(_i8.PageRouteInfo<dynamic>? route,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#push, [route], {#onFailure: onFailure}),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i7.Future<T?> replace<T extends Object?>(_i8.PageRouteInfo<dynamic>? route,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#replace, [route], {#onFailure: onFailure}),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i7.Future<void> pushAll(List<_i8.PageRouteInfo<dynamic>>? routes,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#pushAll, [routes], {#onFailure: onFailure}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> popAndPushAll(List<_i8.PageRouteInfo<dynamic>>? routes,
          {dynamic onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#popAndPushAll, [routes], {#onFailure: onFailure}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> replaceAll(List<_i8.PageRouteInfo<dynamic>>? routes,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#replaceAll, [routes], {#onFailure: onFailure}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void popUntilRoot() =>
      super.noSuchMethod(Invocation.method(#popUntilRoot, []),
          returnValueForMissingStub: null);
  @override
  _i7.Future<T?> popAndPush<T extends Object?, TO extends Object?>(
          _i8.PageRouteInfo<dynamic>? route,
          {TO? result,
          _i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(
              #popAndPush, [route], {#result: result, #onFailure: onFailure}),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  bool removeUntil(_i6.RouteDataPredicate? predicate) =>
      (super.noSuchMethod(Invocation.method(#removeUntil, [predicate]),
          returnValue: false) as bool);
  @override
  void popUntil(_i4.RoutePredicate? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  bool removeWhere(_i6.RouteDataPredicate? predicate) =>
      (super.noSuchMethod(Invocation.method(#removeWhere, [predicate]),
          returnValue: false) as bool);
  @override
  void updateDeclarativeRoutes(List<_i8.PageRouteInfo<dynamic>>? routes) =>
      super.noSuchMethod(Invocation.method(#updateDeclarativeRoutes, [routes]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<void> navigateAll(List<_i6.RouteMatch<dynamic>>? routes,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#navigateAll, [routes], {#onFailure: onFailure}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<T?> pushAndPopUntil<T extends Object?>(
          _i8.PageRouteInfo<dynamic>? route,
          {_i4.RoutePredicate? predicate,
          _i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#pushAndPopUntil, [route],
              {#predicate: predicate, #onFailure: onFailure}),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i7.Future<T?> replaceNamed<T extends Object?>(String? path,
          {bool? includePrefixMatches = false,
          _i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#replaceNamed, [
            path
          ], {
            #includePrefixMatches: includePrefixMatches,
            #onFailure: onFailure
          }),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  _i7.Future<T?> pushNamed<T extends Object?>(String? path,
          {bool? includePrefixMatches = false,
          _i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamed, [
            path
          ], {
            #includePrefixMatches: includePrefixMatches,
            #onFailure: onFailure
          }),
          returnValue: Future<T?>.value()) as _i7.Future<T?>);
  @override
  void popUntilRouteWithName(String? name) =>
      super.noSuchMethod(Invocation.method(#popUntilRouteWithName, [name]),
          returnValueForMissingStub: null);
  @override
  void refresh() => super.noSuchMethod(Invocation.method(#refresh, []),
      returnValueForMissingStub: null);
  @override
  void markUrlStateForReplace() =>
      super.noSuchMethod(Invocation.method(#markUrlStateForReplace, []),
          returnValueForMissingStub: null);
  @override
  void attachChildController(_i6.RoutingController? childController) =>
      super.noSuchMethod(
          Invocation.method(#attachChildController, [childController]),
          returnValueForMissingStub: null);
  @override
  void removeChildController(_i6.RoutingController? childController) =>
      super.noSuchMethod(
          Invocation.method(#removeChildController, [childController]),
          returnValueForMissingStub: null);
  @override
  bool isRouteActive(String? routeName) =>
      (super.noSuchMethod(Invocation.method(#isRouteActive, [routeName]),
          returnValue: false) as bool);
  @override
  bool isRouteKeyActive(_i2.Key? key) =>
      (super.noSuchMethod(Invocation.method(#isRouteKeyActive, [key]),
          returnValue: false) as bool);
  @override
  bool isPathActive(String? path) =>
      (super.noSuchMethod(Invocation.method(#isPathActive, [path]),
          returnValue: false) as bool);
  @override
  _i7.Future<dynamic> navigate(_i8.PageRouteInfo<dynamic>? route,
          {_i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#navigate, [route], {#onFailure: onFailure}),
          returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<void> navigateNamed(String? path,
          {bool? includePrefixMatches = false,
          _i9.OnNavigationFailure? onFailure}) =>
      (super.noSuchMethod(
          Invocation.method(#navigateNamed, [
            path
          ], {
            #includePrefixMatches: includePrefixMatches,
            #onFailure: onFailure
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void navigateBack() =>
      super.noSuchMethod(Invocation.method(#navigateBack, []),
          returnValueForMissingStub: null);
  @override
  T? innerRouterOf<T extends _i6.RoutingController>(String? routeName) =>
      (super.noSuchMethod(Invocation.method(#innerRouterOf, [routeName]))
          as T?);
  @override
  _i7.Future<bool> popTop<T extends Object?>([T? result]) =>
      (super.noSuchMethod(Invocation.method(#popTop, [result]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  String toString() => super.toString();
  @override
  void addListener(_i10.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i10.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
