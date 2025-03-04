// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/order/view/recipient_tab_view.dart';
import 'package:ase/presentation/pages/profile/views/order/view/sender_tab_view.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "OrderHistoryRoute")
class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with TickerProviderStateMixin {
  late final TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(LocaleKeys.navigation_order_history.tr()),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
          ),
          leading: BackButton(style: CustomBoxDecoration.backButtonStyle())),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: CustomBoxDecoration().copyWith(
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelColor: ColorConstants.white,
                unselectedLabelColor: ColorConstants.grey,
                indicator: BoxDecoration(
                  color: ColorConstants.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                splashBorderRadius: BorderRadius.circular(14),
                overlayColor: WidgetStateProperty.all(ColorConstants.primary),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller,
                tabs: [
                  Tab(text: LocaleKeys.general_i_sender.tr()),
                  Tab(text: LocaleKeys.general_i_recipient.tr()),
                ]),
          ),
          Expanded(
            child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  SenderTabView(),
                  RecipientTabView(),
                ]),
          ),
        ],
      ),
    );
  }
}
