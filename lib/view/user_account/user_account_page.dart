import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../view.dart';
import 'option_menu_list_tile.dart';
import 'user_image.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = GetIt.I.get<AppPresenter>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(flex: 2),
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
            onPressed: doNothing,
          ),
          SizedBox(height: 30.height),
        ],
      ),
    );
  }

  void showOrders() {
    //
  }

  void doNothing() {}
}
