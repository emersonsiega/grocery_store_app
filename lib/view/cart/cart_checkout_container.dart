import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';
import '../view.dart';

class CartCheckoutContainer extends StatelessWidget {
  final CartEntity cart;
  final bool withShadow;
  final VoidCallback onConfirm;
  final bool isLoading;

  const CartCheckoutContainer({
    Key? key,
    required this.cart,
    required this.onConfirm,
    this.withShadow = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.width),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        boxShadow: [
          if (withShadow)
            BoxShadow(
              color: context.theme.dividerColor,
              blurRadius: 2,
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "${cart.totalItems} ite${cart.totalItems == 1 ? 'm' : 'ns'}",
                style: context.textTheme.headline6?.copyWith(
                  color: context.colorScheme.onBackground,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: "Total ",
                  style: context.textTheme.headline6?.copyWith(
                    color: context.colorScheme.onBackground,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: cart.total.currency,
                      style: context.textTheme.headline6?.copyWith(
                        color: context.colorScheme.primary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.height),
          LoadingElevatedButton(
            text: "FINALIZAR COMPRA",
            isLoading: isLoading,
            onPressed: onConfirm,
          ),
          SizedBox(height: 10.height),
        ],
      ),
    );
  }
}
