import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

class RoundedIconButton extends StatefulWidget {
  final Icon icon;
  final Color backgroundColor;
  final AsyncCallback onPressed;
  final double? size;

  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    this.size,
  }) : super(key: key);

  @override
  State<RoundedIconButton> createState() => _RoundedIconButtonState();
}

class _RoundedIconButtonState extends State<RoundedIconButton> {
  bool isRunning = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size ?? 40.width,
      height: widget.size ?? 40.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: isRunning
            ? () {}
            : () async {
                try {
                  setState(() {
                    isRunning = true;
                  });

                  await widget.onPressed();
                } finally {
                  setState(() {
                    isRunning = false;
                  });
                }
              },
        child: Center(
          child: widget.icon,
        ),
      ),
    );
  }
}
