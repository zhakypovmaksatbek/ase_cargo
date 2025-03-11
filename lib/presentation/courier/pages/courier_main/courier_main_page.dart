import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: 'CourierMainRoute')
class CourierMainPage extends StatefulWidget {
  const CourierMainPage({super.key});

  @override
  State<CourierMainPage> createState() => _CourierMainPageState();
}

class _CourierMainPageState extends State<CourierMainPage> {
  List<PageRouteInfo<dynamic>> get routes => [
        const CHomeRoute(),
        const ScanRoute(),
        const CProfileRoute(),
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
              onTap(1, tabsRouter);
            },
            backgroundColor: ColorConstants.primary,
            child: const Icon(Icons.qr_code_scanner_outlined,
                size: 40, color: Colors.white),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(AssetConstants.home.svg,
                    LocaleKeys.navigation_home.tr(), 0, tabsRouter),
                const SizedBox(width: 50),
                _buildNavItem(AssetConstants.profile.svg,
                    LocaleKeys.navigation_cabinet.tr(), 2, tabsRouter),
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
