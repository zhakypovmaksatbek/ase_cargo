// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/pages/history/order_detail_content.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/products/utils/order_action.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistoryOrderCard extends StatelessWidget {
  HistoryOrderCard({
    super.key,
    required this.order,
  });
  final BoxModel order;
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomSheet.showDefBottomSheet(
            context, COrderHistoryDetailContent(box: order));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: CustomBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            if (order.code != null)
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: CustomBoxDecoration().copyWith(
                    color: ColorConstants.lightSlate,
                  ),
                  child: AppText(
                    title: order.code ?? "",
                    textType: TextType.body,
                    fontWeight: FontWeight.w500,
                  )),
            OrderActionWidget(
                action: OrderAction.fromString(order.action ?? "")),
            HandleAddressWidget(address: Address(addressLine: order.address)),
          ],
        ),
      ),
    );
  }
}

class OrderActionWidget extends StatelessWidget {
  const OrderActionWidget({super.key, required this.action});
  final OrderAction action;

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Flexible(
                  child: AppText(
                    title: action.translatedName,
                    textType: TextType.subtitle,
                    fontWeight: FontWeight.w500,
                    color: action.color,
                  ),
                ),
                CustomAssetImage(
                  path: action.icon,
                  isSvg: true,
                  svgColor: action.color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
