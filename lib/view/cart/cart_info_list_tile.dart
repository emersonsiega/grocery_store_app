import 'package:flutter/material.dart';
import '../view.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

class CartInfoListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isThreeLine;

  const CartInfoListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isThreeLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.dividerColor.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 10.width),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.width),
            color: context.colorScheme.primary,
          ),
          height: 30.width,
          width: 30.width,
          child: Icon(
            icon,
            size: 20.width,
            color: context.colorScheme.onPrimary,
          ),
        ),
        title: Text(
          title,
          style: context.textTheme.bodyText1,
        ),
        subtitle: Text(
          subtitle,
          style: context.textTheme.bodyText2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: isThreeLine,
      ),
    );
  }
}
