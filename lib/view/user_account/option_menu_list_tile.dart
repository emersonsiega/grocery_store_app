import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';

class OptionMenuListTile extends StatelessWidget {
  final String svgIcon;
  final String title;
  final VoidCallback onPressed;
  const OptionMenuListTile({
    Key? key,
    required this.svgIcon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.fontSize),
      ),
      leading: SvgPicture.asset(
        svgIcon,
        width: 30.fontSize,
        height: 30.fontSize,
        color: context.colorScheme.onBackground,
      ),
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: context.textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
