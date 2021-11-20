import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';

abstract class CustomSnackbar {
  // Default settings
  static const _behavior = SnackBarBehavior.floating;
  static const _dismiss = DismissDirection.horizontal;
  static const _shape = StadiumBorder();
  static final _margin = EdgeInsets.all(20.width);
  static final _padding = EdgeInsets.symmetric(
    horizontal: 16.width,
    vertical: 16.height,
  );

  static void showInfo({
    required String? message,
    required BuildContext context,
  }) {
    if (message != null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          _buildInfoSnackbar(message: message, context: context),
        );
    }
  }

  static void showError({
    required String? message,
    required BuildContext context,
  }) {
    if (message != null) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          _buildErrorSnackbar(message: message, context: context),
        );
    }
  }

  static SnackBar _buildInfoSnackbar({
    required String message,
    required BuildContext context,
  }) {
    return SnackBar(
      backgroundColor: context.colorScheme.primaryVariant,
      behavior: _behavior,
      dismissDirection: _dismiss,
      shape: _shape,
      margin: _margin,
      padding: _padding,
      content: Text(
        message,
        style: context.textTheme.subtitle1?.copyWith(
          color: context.colorScheme.background,
        ),
      ),
    );
  }

  static SnackBar _buildErrorSnackbar({
    required String message,
    required BuildContext context,
  }) {
    return SnackBar(
      backgroundColor: context.colorScheme.error,
      behavior: _behavior,
      dismissDirection: _dismiss,
      shape: _shape,
      margin: _margin,
      padding: _padding,
      content: Text(
        message,
        style: context.textTheme.subtitle1?.copyWith(
          color: context.colorScheme.background,
        ),
      ),
    );
  }
}
