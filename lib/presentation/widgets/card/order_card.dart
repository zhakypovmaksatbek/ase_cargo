// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/profile/widgets/status_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/utils/date_time_utils.dart';
import 'package:ase/presentation/utils/order_utils.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
    super.key,
    required this.order,
  });
  final OrderModel order;
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(OrderDetailRoute()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: CustomBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: CustomBoxDecoration().copyWith(
                  color: ColorConstants.lightGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title: order.code ?? "-",
                    textType: TextType.header,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.darkGrey,
                  ),
                  if (order.code != null) CopyButton(content: order.code ?? "-")
                ],
              ),
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
                        title: OrderUtils.formatAddress(
                            order.address ?? Address()),
                        textType: TextType.body,
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            StatusWidget(
              status: order.orderStatus,
              title: LocaleKeys.general_status_order.tr(),
              statusTextFunction: OrderUtils.orderStatus,
              statusColorFunction: OrderUtils.orderStatusColor,
              statusIconFunction: OrderUtils.orderStatusIcon,
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_delivery_type.tr(),
              subtitle: order.shipmentOptionName ?? "-",
            ),
            _buildOrderDeliveryInfo(
              title: LocaleKeys.general_weight.tr(),
              subtitle: "${order.totalWeight ?? 0} кг",
            ),
            Divider(color: ColorConstants.dividerColor),
            if (order.shipmentOptionPrice != null)
              _buildOrderDeliveryInfo(
                title: LocaleKeys.general_service_price.tr(),
                subtitle: order.shipmentOptionPrice ?? "-",
              ),
            if (order.totalServicesPrice != null &&
                order.totalServicesPrice != "0.00")
              _buildOrderDeliveryInfo(
                title: LocaleKeys.general_additional_service_price.tr(),
                subtitle: order.totalServicesPrice ?? "0 \$",
              ),
            if (order.price != null)
              _buildOrderDeliveryInfo(
                title: LocaleKeys.general_delivery_price.tr(),
                subtitle: order.price ?? "0 \$",
              ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAssetImage(
                  path: AssetConstants.cash.svg,
                  isSvg: true,
                  svgColor: ColorConstants.grey,
                ),
                AppText(
                    title: LocaleKeys.general_paid.tr(),
                    fontWeight: FontWeight.w500,
                    textType: TextType.body),
                Spacer(),
                AppText(
                    title: ShipmentOption.fromString(order.paidBy ?? "-")
                        .title
                        .tr(),
                    fontWeight: FontWeight.w500,
                    textType: TextType.body),
              ],
            ),
            ReminderMessageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: AppText(
                          title: LocaleKeys.general_date.tr(),
                          textType: TextType.subtitle,
                          color: ColorConstants.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CustomAssetImage(
                        path: AssetConstants.send.svg,
                        isSvg: true,
                      ),
                      Flexible(
                        child: AppText(
                          title: DateTimeUtils.formatDate(
                              order.deadlines?.departureTime ?? "-",
                              format: "dd.MM.yyyy"),
                          textType: TextType.subtitle,
                          color: ColorConstants.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomAssetImage(
                        path: AssetConstants.get.svg,
                        isSvg: true,
                      ),
                      Flexible(
                        child: AppText(
                          title: DateTimeUtils.formatDate(
                              order.deadlines?.departureTime ?? "-"),
                          textType: TextType.subtitle,
                          color: ColorConstants.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String paidBy(String value) {
    switch (value) {
      case "recipient":
        return LocaleKeys.general_by_recipient.tr();
      case "sender":
        return LocaleKeys.general_by_sender.tr();
      default:
        return value;
    }
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

class CopyButton extends StatefulWidget {
  final String content;
  const CopyButton({super.key, required this.content});

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool copied = false;

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.content));
    setState(() => copied = true);

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: copyToClipboard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: copied
            ? CustomAssetImage(
                key: ValueKey('check'),
                path: AssetConstants.done.svg,
                height: 24,
                width: 24,
                svgColor: ColorConstants.grey,
                isSvg: true)
            : Icon(Icons.copy,
                key: ValueKey('copy'), color: ColorConstants.grey, size: 24),
      ),
    );
  }
}

class ReminderMessageWidget extends StatelessWidget {
  const ReminderMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration:
          CustomBoxDecoration().copyWith(color: ColorConstants.lightGrey),
      child: Row(
        spacing: 10,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: CustomBoxDecoration.circleDecoration().copyWith(
                color: ColorConstants.lightGrey,
                border: Border.all(color: ColorConstants.white, width: 6)),
            child: Icon(Icons.error_outline, color: ColorConstants.primary),
          ),
          Flexible(
            child: AppText(
              title: LocaleKeys.notification_order_will_be_shipped.tr(),
              textType: TextType.body,
              color: ColorConstants.primary,
            ),
          )
        ],
      ),
    );
  }
}
