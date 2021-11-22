import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';
import '../view.dart';

class CartItemListTile extends StatefulWidget {
  final CartItemEntity item;

  const CartItemListTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<CartItemListTile> createState() => _CartItemListTileState();
}

class _CartItemListTileState extends State<CartItemListTile> {
  bool bgVisible = true;

  @override
  Widget build(BuildContext context) {
    final presenter = GetIt.I.get<CartPresenter>();

    return Stack(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          opacity: bgVisible ? 1.0 : 0.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            height: bgVisible ? 130.height : 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.error.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: bgVisible ? 1.0 : 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(10.fontSize),
                      child: Center(
                        child: Icon(
                          Icons.delete_outline_outlined,
                          size: 40.fontSize,
                          color: context.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Dismissible(
          key: Key("Dismiss-${widget.item.id}"),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => presenter.removeItem(widget.item),
          onResize: () {
            setState(() {
              bgVisible = false;
            });
          },
          child: Container(
            height: 130.height,
            padding: EdgeInsets.symmetric(
              horizontal: 18.width,
              vertical: 14.height,
            ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    widget.item.product.imagePath,
                    width: 70.fontSize,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(width: 24.width),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.item.product.name,
                        textAlign: TextAlign.left,
                        style: context.textTheme.bodyText1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.item.product.price.currency,
                            style: context.textTheme.bodyText2?.copyWith(
                              color: context.theme.dividerColor,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(width: 3.width),
                          Text(
                            "/${widget.item.product.unitType.name.substring(0, 2)}",
                            style: context.textTheme.bodyText2?.copyWith(
                              color: context.theme.dividerColor,
                              height: 1.5,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.item.total.currency,
                            style: context.textTheme.bodyText1?.copyWith(
                              color: context.colorScheme.primary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.height),
                      Row(
                        children: [
                          const Spacer(),
                          RoundedIconButton(
                            key: Key("DecreaseItem${widget.item.id}"),
                            backgroundColor: context.theme.dividerColor,
                            icon: Icon(
                              Icons.remove,
                              size: 20.fontSize,
                            ),
                            onPressed: () => presenter.decrease(widget.item),
                          ),
                          Container(
                            width: 44.width,
                            padding: EdgeInsets.symmetric(horizontal: 6.width),
                            child: Text(
                              widget.item.quantity
                                  .toStringAsFixed(0)
                                  .padLeft(2, '0'),
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyText1?.copyWith(
                                color: context.colorScheme.onBackground,
                                height: 1.5,
                              ),
                            ),
                          ),
                          RoundedIconButton(
                            key: Key("IncreaseItem${widget.item.id}"),
                            backgroundColor: context.colorScheme.primary,
                            icon: Icon(
                              Icons.add,
                              size: 20.fontSize,
                            ),
                            onPressed: () => presenter.increase(widget.item),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
