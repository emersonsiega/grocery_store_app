import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';

class OrderItemListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;
  final AsyncCallback onPressed;
  final bool isThreeLine;

  const OrderItemListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.index,
    required this.onPressed,
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
            color: context.theme.dividerColor,
          ),
          height: 30.width,
          width: 30.width,
          child: Center(
            child: Text(
              "$index",
              style: context.textTheme.bodyText1?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
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
        trailing: RoundedIconButton(
          backgroundColor: context.colorScheme.primary,
          onPressed: onPressed,
          icon: Icon(
            Icons.print,
            color: context.colorScheme.onPrimary,
            size: 20.fontSize,
          ),
        ),
      ),
    );
  }
}
