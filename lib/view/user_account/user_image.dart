import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../../domain/domain.dart';
import '../view.dart';

class UserImage extends StatelessWidget {
  final UserEntity user;

  const UserImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100.fontSize,
            width: 100.fontSize,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.account,
                height: 60.fontSize,
                width: 60.fontSize,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
          SizedBox(height: 15.height),
          Text(
            user.name,
            style: context.textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
