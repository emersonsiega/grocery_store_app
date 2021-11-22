import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

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
      lazyLoad: false,
      routes: const [
        HomeRoute(),
        CartRoute(),
        UserAccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        final activeColor = context.colorScheme.primary;
        final inactiveColor = context.theme.dividerColor;

        final activeTextStyle = TextStyle(
          color: activeColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
          fontSize: 12,
        );

        final inactiveTextStyle = TextStyle(
          color: inactiveColor,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );

        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: inactiveColor.withOpacity(0.7),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Theme(
              data: context.theme.copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: StreamBuilder<AppState>(
                  stream: presenter.stream,
                  initialData: const AppState(),
                  builder: (context, snapshot) {
                    return BottomNavigationBar(
                      currentIndex: tabsRouter.activeIndex,
                      onTap: tabsRouter.setActiveIndex,
                      items: [
                        BottomNavigationBarItem(
                          label: 'Home',
                          icon: BottomNavigationCustomIcon(
                            svgIcon: AppIcons.home,
                            isActive: tabsRouter.activeIndex == 0,
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'Carrinho',
                          icon: BottomNavigationCustomIcon(
                            svgIcon: AppIcons.cart,
                            isActive: tabsRouter.activeIndex == 1,
                            showIndicator: snapshot.data?.cart != null &&
                                snapshot.data!.cart!.totalItems > 0,
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'Conta',
                          icon: BottomNavigationCustomIcon(
                            svgIcon: AppIcons.account,
                            isActive: tabsRouter.activeIndex == 2,
                          ),
                        ),
                      ],
                      iconSize: 30.fontSize,
                      selectedLabelStyle: activeTextStyle,
                      unselectedLabelStyle: inactiveTextStyle,
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}

class BottomNavigationCustomIcon extends StatelessWidget {
  final bool isActive;
  final String svgIcon;
  final bool showIndicator;

  const BottomNavigationCustomIcon({
    Key? key,
    this.isActive = false,
    this.showIndicator = false,
    required this.svgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colorScheme.primary;
    final inactiveColor = context.theme.dividerColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      height: 55.height,
      width: 55.height,
      margin: EdgeInsets.only(bottom: 5.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.fontSize),
        color: isActive ? activeColor.withOpacity(0.25) : Colors.transparent,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              svgIcon,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
          if (showIndicator)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 10.fontSize,
                width: 10.fontSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.fontSize),
                  color: activeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
