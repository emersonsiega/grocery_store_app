import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../view.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late AppPresenter presenter;

  @override
  void initState() {
    super.initState();

    presenter = GetIt.I.get();

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => presenter.loadAppState());
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        CartRoute(),
        UserAccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Carrinho',
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              label: 'Conta',
              icon: Icon(Icons.person),
            ),
          ],
        );
      },
    );
  }
}
