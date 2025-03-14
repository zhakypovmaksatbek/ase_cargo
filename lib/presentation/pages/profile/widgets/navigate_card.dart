import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/locale/product_localization.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NavigateCard extends StatelessWidget {
  const NavigateCard({
    super.key,
    this.isCourier = false,
  });
  static final router = getIt<AppRouter>();
  final bool isCourier;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBoxDecoration().copyWith(
        boxShadow: BoxDecorationValues.listTileBoxShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _navigateWidget(
            context,
            title: LocaleKeys.navigation_profile.tr(),
            icon: AssetConstants.userInfo.svg,
            onTap: () => router.push(UserInfoRoute()),
          ),
          Divider(
            color: ColorConstants.dividerColor,
          ),
          _navigateWidget(
            context,
            title: LocaleKeys.navigation_language.tr(),
            icon: AssetConstants.language.svg,
            activateTrailingWidget: true,
          ),
          Divider(
            color: ColorConstants.dividerColor,
          ),
          if (!isCourier)
            _navigateWidget(context,
                title: LocaleKeys.navigation_my_reviews.tr(),
                icon: AssetConstants.myReview.svg,
                onTap: () => router.push(MyReviewsRoute())),
          if (!isCourier)
            Divider(
              color: ColorConstants.dividerColor,
            ),
          _navigateWidget(
            context,
            title: LocaleKeys.navigation_notifications.tr(),
            icon: AssetConstants.notification.svg,
          ),
        ],
      ),
    );
  }

  InkWell _navigateWidget(BuildContext context,
      {required String title,
      required String icon,
      void Function()? onTap,
      bool activateTrailingWidget = false}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Row(
          children: [
            CustomAssetImage(
              path: icon,
              isSvg: true,
            ),
            const SizedBox(width: 10),
            AppText(
              title: title,
              textType: TextType.body,
              color: ColorConstants.lightBlack,
              fontWeight: FontWeight.w500,
            ),
            Spacer(),
            if (activateTrailingWidget)
              PopupMenuButton<String>(
                icon: const Icon(Icons.keyboard_arrow_down),
                padding: EdgeInsets.zero,
                menuPadding: EdgeInsets.zero,
                onSelected: (value) {},
                itemBuilder: (context) => Locales.values.map((e) {
                  return PopupMenuItem<String>(
                    value: e.name,
                    onTap: () {
                      ProductLocalizationService.updateLanguage(
                          context: context, value: e);
                    },
                    child: Text(e.name.tr()),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
