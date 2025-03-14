// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/bloc/take_order/take_order_cubit.dart';
import 'package:ase/data/bloc/update_order_status/update_order_status_cubit.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/pages/home/content/canceled_content.dart';
import 'package:ase/presentation/courier/pages/home/content/i_have_content.dart';
import 'package:ase/presentation/widgets/error/error_toast.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/tab_bar/custom_tab_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'CHomeRoute')
class CHomePage extends StatefulWidget {
  const CHomePage({super.key});

  @override
  State<CHomePage> createState() => _CHomePageState();
}

class _CHomePageState extends State<CHomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController controller;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    _getHomeData();

    super.initState();
  }

  void _getHomeData() {
    context.read<UserCubit>().getUser();
  }

  void updateBoxes() {
    context.read<BoxCubit>().getBox(CourierOrderStatus.active, isRefresh: true);
    context
        .read<BoxCubit>()
        .getBox(CourierOrderStatus.cancelled, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<TakeOrderCubit, TakeOrderState>(
      listener: (context, state) {
        if (state is TakeOrderLoaded) updateBoxes();
      },
      child: BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
        listener: (context, state) {
          if (state is UpdateOrderStatusSuccess) {
            updateBoxes();
          } else if (state is UpdateOrderStatusError) {
            ErrorToast.defExceptionToast(context, state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: CustomAssetImage(
              path: AssetConstants.logo.png,
              height: 30,
            ),
            actions: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorConstants.grey)),
                child: CustomAssetImage(
                  path: AssetConstants.notification.svg,
                  svgColor: ColorConstants.primary,
                  isSvg: true,
                ),
              ),
            ],
          ),
          body: Column(
            spacing: 20,
            children: [
              CustomTabBar(
                controller: controller,
                tabs: [
                  Tab(text: LocaleKeys.navigation_i_have.tr()),
                  Tab(text: LocaleKeys.navigation_canceled.tr()),
                ],
              ),
              Expanded(
                child: TabBarView(controller: controller, children: [
                  IHaveTabContent(),
                  CanceledTabContent(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
