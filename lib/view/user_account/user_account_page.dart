import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';
import 'option_menu_list_tile.dart';
import 'user_image.dart';
import 'user_orders_bottom_sheet.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  late AppPresenter presenter;

  @override
  void initState() {
    presenter = GetIt.I.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
      stream: presenter.stream,
      initialData: presenter.state,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(flex: 2),
              if (presenter.state.currentUser != null)
                UserImage(user: presenter.state.currentUser!),
              const Spacer(flex: 2),
              OptionMenuListTile(
                title: "Pedidos",
                svgIcon: AppIcons.bag,
                onPressed: showOrders,
              ),
              OptionMenuListTile(
                title: "Configurações",
                svgIcon: AppIcons.settings,
                onPressed: doNothing,
              ),
              OptionMenuListTile(
                title: "Endereços",
                svgIcon: AppIcons.map,
                onPressed: doNothing,
              ),
              OptionMenuListTile(
                title: "Fale conosco",
                svgIcon: AppIcons.chat,
                onPressed: doNothing,
              ),
              const Spacer(flex: 1),
              OptionMenuListTile(
                title: "Sair",
                svgIcon: AppIcons.exit,
                onPressed: onExit,
              ),
              SizedBox(height: 30.height),
            ],
          ),
        );
      },
    );
  }

  void showOrders() async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      useRootNavigator: true,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return const UserOrdersBottomSheet();
      },
    );
  }

  void doNothing() {}

  void onExit() {
    AutoRouter.of(context).replace(const LoginRoute());
    //TODO: create logout method
    presenter.clearAppState();
  }
}
