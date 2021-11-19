import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import 'load_page_utils.mocks.dart';

@GenerateMocks([StackRouter])
Widget _makeMaterialApp(Widget child) {
  return MaterialApp(
    home: LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            ResponsiveConfig(
              designScreenWidth: 414,
              designScreenHeight: 736,
            ).init(constraints, orientation);

            return child;
          },
        );
      },
    ),
  );
}

Future<MockStackRouter> loadPageWithNavigation(
  WidgetTester tester,
  Widget page,
) async {
  MockStackRouter routerSpy = MockStackRouter();

  when(routerSpy.replace(any)).thenAnswer((_) async => null);

  final widget = StackRouterScope(
    controller: routerSpy,
    stateHash: 0,
    child: _makeMaterialApp(page),
  );

  await tester.pumpWidget(widget);

  return routerSpy;
}

Future<void> loadPage(WidgetTester tester, Widget page) async {
  final widget = _makeMaterialApp(page);

  await tester.pumpWidget(widget);
}
