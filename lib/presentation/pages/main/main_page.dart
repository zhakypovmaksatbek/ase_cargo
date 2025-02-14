import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: 'MainRoute')
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PageRouteInfo<dynamic>> get routes => [
        const HomeRoute(),
        const TrackingRoute(),
        const CreateOrderRoute(),
        const SupportRoute(),
        const ProfileRouterRoute(),
      ];

  void onTap(int index, TabsRouter tabsRouter) {
    if (tabsRouter.activeIndex == index) {
      tabsRouter.stackRouterOfIndex(index)?.maybePop();
    } else {
      tabsRouter.setActiveIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: routes,
      homeIndex: 0,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              onTap(2, tabsRouter);
            },
            backgroundColor: ColorConstants.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 0,
            elevation: 18,
            shadowColor: ColorConstants.black,
            shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(AssetConstants.home.svg,
                    LocaleKeys.navigation_home.tr(), 0, tabsRouter),
                _buildNavItem(AssetConstants.search.svg,
                    LocaleKeys.navigation_tracking.tr(), 1, tabsRouter),
                const SizedBox(width: 50), // FAB için boşluk
                _buildNavItem(AssetConstants.support.svg,
                    LocaleKeys.navigation_support.tr(), 3, tabsRouter),
                _buildNavItem(AssetConstants.profile.svg,
                    LocaleKeys.navigation_cabinet.tr(), 4, tabsRouter),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      String iconPath, String label, int index, TabsRouter tabsRouter) {
    final isSelected = tabsRouter.activeIndex == index;
    return InkWell(
      onTap: () => onTap(index, tabsRouter),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.blue.shade900 : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue.shade900 : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
