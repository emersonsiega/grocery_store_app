import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../view.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

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
