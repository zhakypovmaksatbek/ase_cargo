import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'CreateOrderRoute')
class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});
  static final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverFillRemaining(
              child: Center(
                  child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomAssetImage(
                      path: AssetConstants.order.svg,
                      isSvg: true,
                    ),
                  ),
                  SizedBox(height: 23.5),
                  AppText(
                      title: LocaleKeys.general_new_order.tr(),
                      textType: TextType.title),
                  AppText(
                    title: LocaleKeys.general_select_role.tr(),
                    textType: TextType.header,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.darkGrey,
                  ),
                  SizedBox(height: 21.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: DefElevatedButton(
                          text: LocaleKeys.navigation_sender.tr(),
                          // horizontalPadding: 20,
                          radius: 20,
                          onPressed: () {
                            router.push(const SenderFormRoute());
                          },
                        ),
                      ),
                      Expanded(
                        child: DefElevatedButton(
                          text: LocaleKeys.navigation_recipient.tr(),
                          // horizontalPadding: 20,
                          radius: 20,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
