import 'package:flutter/material.dart';

import '../view.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Grocery Store",
      style: context.theme.primaryTextTheme.headline3?.copyWith(
        color: context.colorScheme.secondary,
      ),
    );
  }
}
