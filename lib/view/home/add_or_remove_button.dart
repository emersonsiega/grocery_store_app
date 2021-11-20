import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';

class AddOrRemoveButton extends StatelessWidget {
  final bool canAdd;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const AddOrRemoveButton({
    Key? key,
    this.canAdd = true,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = canAdd ? "ADICIONAR" : "REMOVER";
    final icon = canAdd ? Icons.add : Icons.remove;
    final color =
        canAdd ? context.colorScheme.primary : context.theme.dividerColor;
    final onPressed = canAdd ? onAdd : onRemove;

    return SizedBox(
      height: 32.height,
      child: ElevatedButton.icon(
        style: context.theme.elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStateProperty.all(color),
          shadowColor: MaterialStateProperty.all(color.withOpacity(0.6)),
        ),
        onPressed: onPressed,
        label: Text(
          text,
          style: context.textTheme.button?.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        icon: Icon(icon, size: 16.fontSize),
      ),
    );
  }
}
