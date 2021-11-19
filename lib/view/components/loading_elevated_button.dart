import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import 'components.dart';

class LoadingElevatedButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  const LoadingElevatedButton({
    Key? key,
    this.isLoading = false,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 25.fontSize,
              height: 25.fontSize,
              child: const Loading(),
            )
          : Text(text),
    );
  }
}
