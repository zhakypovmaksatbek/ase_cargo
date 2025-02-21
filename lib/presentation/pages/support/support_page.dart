import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SupportRoute')
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});
  static final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverSafeArea(
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 20,
              children: [
                InkWell(
                  overlayColor:
                      WidgetStatePropertyAll(ColorConstants.backgroundLight),
                  onTap: () {
                    router.push(OnlineChatRoute());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: CustomBoxDecoration()
                        .copyWith(color: ColorConstants.primary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title: LocaleKeys.navigation_online_chat.tr(),
                          textType: TextType.body,
                          color: ColorConstants.white,
                        ),
                        Icon(
                          Icons.navigate_next_outlined,
                          color: ColorConstants.white,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: CustomBoxDecoration().copyWith(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20,
                    children: [
                      Row(
                        spacing: 16,
                        children: [
                          CustomAssetImage(
                            path: AssetConstants.call.svg,
                            isSvg: true,
                          ),
                          AppText(
                            title: "Позвонить",
                            textType: TextType.body,
                          ),
                        ],
                      ),
                      Row(
                        spacing: 16,
                        children: [
                          CustomAssetImage(
                            path: AssetConstants.whatsapp.svg,
                            isSvg: true,
                          ),
                          AppText(
                            title: "Написать в WhatsApp",
                            textType: TextType.body,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: ColorConstants.grey, width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Row(
                      spacing: 10,
                      children: [
                        CustomAssetImage(
                          path: AssetConstants.location.svg,
                          isSvg: true,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: LocaleKeys.general_office_address.tr(),
                                textType: TextType.description,
                                color: ColorConstants.lavenderBlue,
                              ),
                              AppText(
                                title:
                                    "г. Бишкек, Турусбеков 109 kjsdnkfnsdkf djfnlsdj bfklsdbfjsbksf kfsbdf",
                                textType: TextType.body,
                                color: ColorConstants.primary,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
