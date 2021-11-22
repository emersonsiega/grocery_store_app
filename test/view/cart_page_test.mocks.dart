// Mocks generated by Mockito 5.0.16 from annotations
// in grocery_store_app/test/view/cart_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:grocery_store_app/domain/domain.dart' as _i4;
import 'package:grocery_store_app/view/view.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAppState_0 extends _i1.Fake implements _i2.AppState {}

class _FakeCartState_1 extends _i1.Fake implements _i2.CartState {}

/// A class which mocks [AppPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppPresenter extends _i1.Mock implements _i2.AppPresenter {
  MockAppPresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<_i2.AppState> get stream => (super.noSuchMethod(
      Invocation.getter(#stream),
      returnValue: Stream<_i2.AppState>.empty()) as _i3.Stream<_i2.AppState>);
  @override
  _i2.AppState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeAppState_0()) as _i2.AppState);
  @override
  _i3.Future<void> loadAppState() =>
      (super.noSuchMethod(Invocation.method(#loadAppState, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  void clearAppState() =>
      super.noSuchMethod(Invocation.method(#clearAppState, []),
          returnValueForMissingStub: null);
  @override
  void updateCart(_i4.CartEntity? cart) =>
      super.noSuchMethod(Invocation.method(#updateCart, [cart]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [CartPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockCartPresenter extends _i1.Mock implements _i2.CartPresenter {
  MockCartPresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<_i2.CartState> get stream => (super.noSuchMethod(
      Invocation.getter(#stream),
      returnValue: Stream<_i2.CartState>.empty()) as _i3.Stream<_i2.CartState>);
  @override
  _i2.CartState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeCartState_1()) as _i2.CartState);
  @override
  _i3.Future<void> increase(_i4.CartItemEntity? cartItem) =>
      (super.noSuchMethod(Invocation.method(#increase, [cartItem]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> decrease(_i4.CartItemEntity? cartItem) =>
      (super.noSuchMethod(Invocation.method(#decrease, [cartItem]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> removeItem(_i4.CartItemEntity? cartItem) =>
      (super.noSuchMethod(Invocation.method(#removeItem, [cartItem]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> makeOrder() =>
      (super.noSuchMethod(Invocation.method(#makeOrder, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}