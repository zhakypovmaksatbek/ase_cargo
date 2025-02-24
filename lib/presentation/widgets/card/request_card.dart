import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  RequestCard({
    super.key,
  });
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(RequestDetailRoute()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: CustomBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            AppText(
              title: "Заявка 1234",
              textType: TextType.body,
              fontWeight: FontWeight.w500,
            ),
            Row(
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
            ),
            _buildOrderStatus(),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_delivery_type.tr(),
              subtitle: "Экспресс (3 рабочих дня)",
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_weight.tr(),
              subtitle: "1,5 кг",
            ),
            Divider(color: ColorConstants.dividerColor),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_service_price.tr(),
              subtitle: "3000 ₽",
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_additional_service_price.tr(),
              subtitle: "3000 ₽",
            ),
            SizedBox(
                width: double.infinity,
                child: DefElevatedButton(
                  verticalPadding: 12,
                  text: LocaleKeys.general_pay.tr(),
                  onPressed: () {
                    router.push(PaymentRoute());
                  },
                ))
          ],
        ),
      ),
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

  Row _buildOrderDeliveryInfo(
      {required String title, required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: title,
          textType: TextType.body,
          color: ColorConstants.darkGrey,
        ),
        Flexible(
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
}
