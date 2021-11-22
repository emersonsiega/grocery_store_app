import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../../view/view.dart';

class CartCheckoutBottomSheet extends StatelessWidget {
  const CartCheckoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartPresenter = GetIt.I.get<CartPresenter>();
    final cart = GetIt.I.get<AppPresenter>().state.cart!;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        color: context.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 24.height,
                left: 24.width,
              ),
              child: Text(
                "Destinatário",
                style: context.textTheme.headline6,
              ),
            ),
            SizedBox(height: 16.height),
            CartInfoListTile(
              title: cart.user.name,
              subtitle: "CPF: ${cart.user.cpf}",
              icon: Icons.person,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 24.height,
                left: 24.width,
              ),
              child: Text(
                "Entrega",
                style: context.textTheme.headline6,
              ),
            ),
            SizedBox(height: 16.height),
            CartInfoListTile(
              title: "Endereço: ${cart.user.mainAddress.title}",
              subtitle:
                  "${cart.user.mainAddress.street}, ${cart.user.mainAddress.number} - CEP: ${cart.user.mainAddress.zipCode}\n${cart.user.mainAddress.city} - ${cart.user.mainAddress.state}",
              icon: Icons.map_sharp,
              isThreeLine: true,
            ),
            SizedBox(height: 30.height),
            StreamBuilder<CartState>(
              stream: cartPresenter.stream,
              builder: (context, snapshot) {
                return CartCheckoutContainer(
                  cart: cart,
                  withShadow: false,
                  onConfirm: cartPresenter.makeOrder,
                  isLoading: snapshot.data?.isLoading ?? false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
