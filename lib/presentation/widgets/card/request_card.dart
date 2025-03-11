// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/pages/profile/widgets/status_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/products/utils/order_utils.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  RequestCard({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(RequestDetailRoute(id: requestModel.id ?? 0)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: CustomBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            AppText(
              title: LocaleKeys.general_request_id
                  .tr(namedArgs: {'id': (requestModel.id ?? "").toString()}),
              textType: TextType.body,
              fontWeight: FontWeight.w500,
            ),
            HandleAddressWidget(address: requestModel.address),
            StatusWidget(
              status: requestModel.status,
              title: LocaleKeys.general_status_order.tr(),
              statusTextFunction: OrderUtils.preOrderStatus,
              statusColorFunction: OrderUtils.preOrderStatusColor,
              statusIconFunction: OrderUtils.preOrderStatusIcon,
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_delivery_type.tr(),
              subtitle: requestModel.deliveryTypeName ?? "",
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_weight.tr(),
              subtitle: "${requestModel.totalWeight ?? 0} кг",
            ),
            Divider(color: ColorConstants.dividerColor),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_service_price.tr(),
              subtitle: "${requestModel.price ?? 0.00} \$",
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_additional_service_price.tr(),
              subtitle: "${requestModel.totalServicesPrice ?? 0.00} \$",
            ),
            if (requestModel.userCanPay ?? false)
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

class PreOrderStatusWidget extends StatelessWidget {
  const PreOrderStatusWidget({
    super.key,
    this.status,
  });
  final String? status;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Flexible(
                  child: AppText(
                    title: OrderUtils.preOrderStatus(status ?? "-"),
                    textType: TextType.subtitle,
                    fontWeight: FontWeight.w500,
                    color: OrderUtils.preOrderStatusColor(status ?? "-"),
                  ),
                ),
                CustomAssetImage(
                  path: OrderUtils.preOrderStatusIcon(status ?? "-"),
                  isSvg: true,
                  svgColor: OrderUtils.preOrderStatusColor(status ?? "-"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
