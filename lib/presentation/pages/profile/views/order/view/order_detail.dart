import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "OrderDetailRoute")
class OrderDetailPage extends StatelessWidget {
  OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DefSliverAppBar(title: LocaleKeys.navigation_order_details.tr()),
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
                  SizedBox(height: 60)
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

  final List<OrderStatusModel> orderStatuses = [
    OrderStatusModel(
      title: "В процессе",
      date: "12.01.2025",
      icon: Icons.access_time,
      status: OrderStatus.completed,
    ),
    OrderStatusModel(
      title: "В пути",
      date: "12.01.2025",
      icon: Icons.local_shipping,
      status: OrderStatus.completed,
    ),
    OrderStatusModel(
      title: "У курьера",
      date: "12.01.2025",
      icon: Icons.person,
      status: OrderStatus.active,
    ),
    OrderStatusModel(
      title: "Доставлен",
      date: "12.01.2025",
      icon: Icons.check_circle,
      status: OrderStatus.upcoming,
    ),
  ];
  Widget _buildOrderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        AppText(
          title: LocaleKeys.general_status_order.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        Column(
          spacing: 16,
          children: orderStatuses.asMap().entries.map((entry) {
            int index = entry.key;
            var step = entry.value;
            bool isLast = index == orderStatuses.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Column(
                  children: [
                    Icon(
                      step.status.icon,
                      color: step.status.color,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 20,
                        color: step.status.color,
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: step.title ?? "",
                      textType: TextType.body,
                      fontWeight: FontWeight.bold,
                      color: step.status.color,
                    ),
                    AppText(
                      title: step.date ?? "",
                      textType: TextType.body,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
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

class OrderStatusModel {
  String? title;
  String? date;
  OrderStatus status;
  IconData? icon;

  OrderStatusModel({this.title, this.date, this.icon, required this.status});

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
        title: json['title'],
        date: json['date'],
        icon: json['icon'],
        status: json['status'] != null &&
                OrderStatus.values
                    .any((e) => e.toString().split('.').last == json['status'])
            ? OrderStatus.values.byName(json['status'])
            : OrderStatus.upcoming);
  }
}

enum OrderStatus {
  active(Icons.radio_button_checked_sharp, ColorConstants.blue),
  completed(Icons.check_circle, ColorConstants.green),
  upcoming(Icons.access_time, ColorConstants.grey),
  canceled(Icons.cancel, ColorConstants.red);

  final Color color;
  final IconData icon;

  const OrderStatus(this.icon, this.color);
}
