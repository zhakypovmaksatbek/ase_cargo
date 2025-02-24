import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "RequestDetailRoute")
class RequestDetail extends StatelessWidget {
  const RequestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        height: 130,
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
                width: double.infinity,
                child: DefElevatedButton(text: LocaleKeys.general_pay.tr())),
            SizedBox(
                width: double.infinity,
                child: DefElevatedButton(
                  text: LocaleKeys.button_cancel.tr(),
                )),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          DefSliverAppBar(title: LocaleKeys.navigation_request_detail.tr()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  _buildAddress(),
                  _buildOrderStatus(),
                  AppText(
                    title: LocaleKeys.general_delivery_info.tr(),
                    textType: TextType.body,
                    color: ColorConstants.lavenderBlue,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: "Беспроводные наушники Sony WH-1000XM5",
                        textType: TextType.header,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        title:
                            "Беспроводная клавиатура с подсветкой и низким профилем клавиш.",
                        textType: TextType.body,
                      ),
                    ],
                  ),
                  _infoCard(),
                  Divider(color: ColorConstants.dividerColor),
                  _buildOrderInfo(
                      title: LocaleKeys.general_service_price.tr(),
                      subtitle: "300 сом"),
                  _buildOrderInfo(
                      title: LocaleKeys.general_additional_service_price.tr(),
                      subtitle: "50 сом"),
                  SizedBox(height: 90)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _infoCard() {
    return Column(
      spacing: 10,
      children: [
        _buildOrderInfo(
            title: LocaleKeys.general_weight.tr(), subtitle: "1,5 кг"),
        _buildOrderInfo(
            title: LocaleKeys.general_delivery_type.tr(),
            subtitle: "Экспресс (3 рабочих дня)"),
        _buildOrderInfo(
            title: LocaleKeys.general_additional_services.tr(),
            subtitle: "Страхование"),
        _buildOrderInfo(
            title: LocaleKeys.general_sender.tr(),
            subtitle: "Иван Петров (Москва)"),
        _buildOrderInfo(
            title: LocaleKeys.general_recipient.tr(),
            subtitle: "Иван Петров (Москва)"),
      ],
    );
  }

  Row _buildOrderInfo({required String title, required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: AppText(
            title: title,
            textType: TextType.body,
            color: ColorConstants.darkGrey,
          ),
        ),
        Flexible(
          flex: 1,
          child: AppText(
            title: subtitle,
            textType: TextType.body,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }

  Row _buildOrderStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        AppText(
          title: LocaleKeys.general_status_order.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: CustomBoxDecoration()
                .copyWith(color: ColorConstants.lightSlate),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Flexible(
                  child: AppText(
                    title: "Ожидает оплаты",
                    textType: TextType.body,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.orange,
                  ),
                ),
                CustomAssetImage(
                  path: AssetConstants.cash.svg,
                  isSvg: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _buildAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
                title: LocaleKeys.general_delivery_address.tr(),
                textType: TextType.subtitle,
                color: ColorConstants.lavenderBlue,
              ),
              AppText(
                title: "г. Бишкек, Турусбеков 109",
                textType: TextType.body,
                color: ColorConstants.primary,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
