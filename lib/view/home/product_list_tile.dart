import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';
import '../../domain/domain.dart';

class ProductListTile extends StatelessWidget {
  final ProductEntity product;
  final bool? canAdd;

  const ProductListTile({
    Key? key,
    required this.product,
    this.canAdd = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = GetIt.I.get<HomePresenter>();

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onBackground.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.height),
            Center(
              child: Image.asset(
                product.imagePath,
                width: 70.fontSize,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Spacer(),
            Text(
              product.name,
              style: context.textTheme.bodyText1,
            ),
            Row(
              children: [
                Text(
                  product.price.currency,
                  style: context.textTheme.bodyText2?.copyWith(
                    color: context.colorScheme.primary,
                    height: 1.5,
                  ),
                ),
                SizedBox(width: 6.width),
                Text(
                  "/${product.unitType.name.substring(0, 2)}",
                  style: context.textTheme.bodyText2?.copyWith(
                    color: context.theme.dividerColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            AddOrRemoveButton(
              key: Key('addOrRemove-${product.id}'),
              canAdd: canAdd ?? true,
              onAdd: () => presenter.addToCart(product),
              onRemove: () => presenter.removeFromCart(product),
            ),
            SizedBox(height: 15.height),
          ],
        ),
      ),
    );
  }
}
