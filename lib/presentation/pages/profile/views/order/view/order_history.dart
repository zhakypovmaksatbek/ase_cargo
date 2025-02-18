import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/card/order_card.dart';
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
      body: CustomScrollView(
        slivers: [
          DefSliverAppBar(title: LocaleKeys.navigation_order_history.tr()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverFillRemaining(
              child: Column(
                children: [
                  Container(
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
                        overlayColor:
                            WidgetStateProperty.all(ColorConstants.primary),
                        indicatorSize: TabBarIndicatorSize.tab,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        controller: controller,
                        tabs: [
                          Tab(text: LocaleKeys.general_i_sender.tr()),
                          Tab(text: LocaleKeys.general_i_recipient.tr()),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: controller, children: [
                      SenderTabView(),
                      RecipientTabView(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SenderTabView extends StatelessWidget {
  const SenderTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrderCard();
        });
  }
}

class RecipientTabView extends StatelessWidget {
  const RecipientTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrderCard();
        });
  }
}
