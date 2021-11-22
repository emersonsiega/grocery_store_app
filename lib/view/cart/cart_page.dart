import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../../view/view.dart';
import '../view.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late AppPresenter appPresenter;
  late CartPresenter cartPresenter;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    appPresenter = GetIt.I.get();
    cartPresenter = GetIt.I.get();

    subscription = cartPresenter.stream.listen(_stateListener);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void _stateListener(CartState state) {
    if (!state.isLoading && state.successMessage != null) {
      CustomSnackbar.showInfo(message: state.successMessage, context: context);

      context.router.pop();
      context.router.navigate(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<AppState>(
        stream: appPresenter.stream,
        initialData: const AppState(),
        builder: (context, snapshot) {
          if (snapshot.data?.cart == null ||
              snapshot.data!.cart!.items.isEmpty) {
            return Center(
              child: Text(
                "Seu carrinho está vazio...",
                style: context.textTheme.headline5?.copyWith(
                  color: context.theme.dividerColor,
                ),
              ),
            );
          }

          final state = snapshot.data!.cart!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.width, top: 14.height),
                child: Text(
                  "Produtos",
                  style: context.textTheme.headline6,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.width,
                    vertical: 14.height,
                  ),
                  itemCount: state.totalItems,
                  itemBuilder: (context, index) {
                    final item = state.items[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.height),
                      child: CartItemListTile(
                        key: ValueKey(item),
                        item: item,
                      ),
                    );
                  },
                ),
              ),
              CartCheckoutContainer(
                cart: state,
                onConfirm: () async {
                  await showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return const CartCheckoutBottomSheet();
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
