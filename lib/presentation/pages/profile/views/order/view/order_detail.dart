// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/order_detail/order_detail_cubit.dart';
import 'package:ase/data/models/order_detail_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/utils/order_utils.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "OrderDetailRoute")
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    super.key,
    required this.orderId,
  });
  final String orderId;
  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late OrderDetailCubit orderDetailCubit;

  @override
  void initState() {
    orderDetailCubit = OrderDetailCubit();
    orderDetailCubit.getOrderDetail(widget.orderId);
    // OrderRepo().getOrderDetail(widget.orderId);
    super.initState();
  }

  @override
  void dispose() {
    orderDetailCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: orderDetailCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            DefSliverAppBar(title: LocaleKeys.navigation_order_details.tr()),
            SliverToBoxAdapter(
              child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
                builder: (context, state) {
                  if (state is OrderDetailSuccess) {
                    final OrderDetailModel detail = state.orderDetail;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          _buildAddress(detail.address ?? Address()),
                          _buildOrderStatus(),
                          AppText(
                            title: LocaleKeys.general_delivery_info.tr(),
                            textType: TextType.body,
                            color: ColorConstants.lavenderBlue,
                          ),
                          if (detail.packages != null)
                            ...detail.packages?.map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (e.name != null)
                                          AppText(
                                            title: e.name ?? "",
                                            textType: TextType.header,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        if (e.description != null)
                                          AppText(
                                            title: e.description ?? "",
                                            textType: TextType.body,
                                          ),
                                      ],
                                    )) ??
                                [],
                          _infoCard(detail),
                          Divider(color: ColorConstants.dividerColor),
                          if (detail.shipmentOptionPrice != "0.00")
                            _buildOrderInfo(
                                title: LocaleKeys.general_service_price.tr(),
                                subtitle: detail.shipmentOptionPrice ?? "0.00"),
                          if (detail.totalServicesPrice != "0.00")
                            _buildOrderInfo(
                                title: LocaleKeys
                                    .general_additional_service_price
                                    .tr(),
                                subtitle: detail.totalServicesPrice ?? "0"),
                          if (detail.price?.isNotEmpty ?? false)
                            _buildOrderInfo(
                                title: LocaleKeys.general_delivery_price.tr(),
                                subtitle: detail.price ?? "0"),
                          SizedBox(height: 60)
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _infoCard(OrderDetailModel detail) {
    return Column(
      spacing: 10,
      children: [
        _buildOrderInfo(
            title: LocaleKeys.general_weight.tr(),
            subtitle: "${detail.totalWeight ?? 0} kg"),
        if (detail.additionServices?.isNotEmpty ?? false)
          _buildOrderInfo(
              title: LocaleKeys.general_delivery_type.tr(),
              subtitle: detail.shipmentOptionName ?? ""),
        if (detail.additionServices?.isNotEmpty ?? false)
          _buildOrderInfo(
              title: LocaleKeys.general_additional_services.tr(),
              subtitle: detail.additionServices?.join(", ") ?? ""),
        _buildOrderInfo(
            title: LocaleKeys.general_sender.tr(),
            subtitle:
                "${detail.sender?.name ?? ""} (${detail.sender?.city ?? ""})"),
        _buildOrderInfo(
            title: LocaleKeys.general_recipient.tr(),
            subtitle:
                "${detail.recipient?.name ?? ""} (${detail.recipient?.city ?? ""})"),
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
      status: OrderState.completed,
    ),
    OrderStatusModel(
      title: "В пути",
      date: "12.01.2025",
      icon: Icons.local_shipping,
      status: OrderState.completed,
    ),
    OrderStatusModel(
      title: "У курьера",
      date: "12.01.2025",
      icon: Icons.person,
      status: OrderState.active,
    ),
    OrderStatusModel(
      title: "Доставлен",
      date: "12.01.2025",
      icon: Icons.check_circle,
      status: OrderState.upcoming,
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

  Row _buildAddress(Address address) {
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
                title: OrderUtils.formatAddress(address),
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
  OrderState status;
  IconData? icon;

  OrderStatusModel({this.title, this.date, this.icon, required this.status});

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
        title: json['title'],
        date: json['date'],
        icon: json['icon'],
        status: json['status'] != null &&
                OrderState.values
                    .any((e) => e.toString().split('.').last == json['status'])
            ? OrderState.values.byName(json['status'])
            : OrderState.upcoming);
  }
}

enum OrderState {
  active(Icons.radio_button_checked_sharp, ColorConstants.blue),
  completed(Icons.check_circle, ColorConstants.green),
  upcoming(Icons.access_time, ColorConstants.grey),
  canceled(Icons.cancel, ColorConstants.red);

  final Color color;
  final IconData icon;

  const OrderState(this.icon, this.color);
}
