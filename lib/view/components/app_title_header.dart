import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../components/components.dart';
import '../view.dart';

class AppTitleHeader extends StatelessWidget {
  const AppTitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          AppImages.loginBackground,
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          width: 414.width,
        ),
        const AppTitle(),
      ],
    );
  }
}
