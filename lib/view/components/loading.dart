import 'package:flutter/material.dart';

import '../view.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.colorScheme.secondary,
        ),
        strokeWidth: 1.5,
      ),
    );
  }
}
