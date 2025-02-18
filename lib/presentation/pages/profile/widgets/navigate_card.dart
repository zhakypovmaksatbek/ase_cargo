import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NavigateCard extends StatelessWidget {
  const NavigateCard({
    super.key,
  });
  static final router = getIt<AppRouter>();
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
            title: LocaleKeys.navigation_profile.tr(),
            icon: AssetConstants.userInfo.svg,
            onTap: () => router.push(UserInfoRoute()),
          ),
          Divider(
            color: ColorConstants.dividerColor,
          ),
          _navigateWidget(
            title: LocaleKeys.navigation_language.tr(),
            icon: AssetConstants.language.svg,
          ),
          Divider(
            color: ColorConstants.dividerColor,
          ),
          _navigateWidget(
              title: LocaleKeys.navigation_my_reviews.tr(),
              icon: AssetConstants.myReview.svg),
          Divider(
            color: ColorConstants.dividerColor,
          ),
          _navigateWidget(
            title: LocaleKeys.navigation_notifications.tr(),
            icon: AssetConstants.notification.svg,
          ),
        ],
      ),
    );
  }

  InkWell _navigateWidget(
      {required String title, required String icon, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
          ],
        ),
      ),
    );
  }
}
