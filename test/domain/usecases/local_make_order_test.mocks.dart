// Mocks generated by Mockito 5.0.16 from annotations
// in grocery_store_app/test/domain/usecases/local_make_order_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:grocery_store_app/data/cache/cache_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [CacheStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockCacheStorage extends _i1.Mock implements _i2.CacheStorage {
  MockCacheStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<dynamic> fetch(String? key) =>
      (super.noSuchMethod(Invocation.method(#fetch, [key]),
          returnValue: Future<dynamic>.value()) as _i3.Future<dynamic>);
  @override
  _i3.Future<void> delete(String? key) =>
      (super.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> save({String? key, dynamic value}) => (super.noSuchMethod(
      Invocation.method(#save, [], {#key: key, #value: value}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
