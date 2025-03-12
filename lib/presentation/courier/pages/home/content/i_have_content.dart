// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/bloc/update_order_status/update_order_status_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/pages/home/widgets/custom_slidable_action.dart';
import 'package:ase/presentation/courier/widgets/card/c_order_card.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_plus_plus/flutter_slidable_plus_plus.dart';

class IHaveTabContent extends StatefulWidget {
  const IHaveTabContent({
    super.key,
  });

  @override
  State<IHaveTabContent> createState() => _IHaveTabContentState();
}

class _IHaveTabContentState extends State<IHaveTabContent>
    with TickerProviderStateMixin {
  late final BoxCubit boxCubit;
  @override
  void initState() {
    super.initState();
    boxCubit = BoxCubit();
    initData();
  }

  Future<void> initData() async {
    boxList.clear();

    await boxCubit.getBox(CourierOrderStatus.active);
  }

  final router = getIt<AppRouter>();
  List<BoxModel> boxList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: boxCubit,
      child: BlocConsumer<BoxCubit, BoxState>(
        listener: (context, state) {
          if (state is BoxLoaded) {
            boxList.addAll(state.box.results ?? []);
          }
        },
        builder: (context, state) {
          if (state is BoxLoading && boxList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BoxError) {
            return Center(child: Text(state.message));
          } else if (boxList.isEmpty) {
            return Center(
                child: Text(LocaleKeys.notification_not_found_order.tr()));
          }
          return RefreshIndicator(
            onRefresh: initData,
            child: BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
              listener: updateOrderStatusListener,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: boxList.length + 1,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    if (index == boxList.length) {
                      return SizedBox(height: 60);
                    }
                    final box = boxList[index];
                    return SlidableAutoCloseBehavior(
                      child: Slidable(
                          key: ValueKey(box.code),
                          dragStartBehavior: DragStartBehavior.down,
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.35,
                              children: [
                                MyCustomSlidableAction(
                                  onPressed: (context) =>
                                      onCancel(context, box),
                                  icon: Icon(Icons.cancel_outlined),
                                  backgroundColor: ColorConstants.red,
                                  label: LocaleKeys.button_cancel.tr(),
                                ),
                              ]),
                          endActionPane: ActionPane(
                              key: ValueKey(box.code),
                              motion: const ScrollMotion(),
                              extentRatio: 0.35,
                              children: [
                                MyCustomSlidableAction(
                                  onPressed: (context) => onDone(context, box),
                                  icon: Icon(Icons.delivery_dining_outlined),
                                  label: LocaleKeys.button_delivered.tr(),
                                ),
                              ]),
                          child: COrderCard(box: box)),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void updateOrderStatusListener(
      BuildContext context, UpdateOrderStatusState state) {
    if (state is UpdateOrderStatusSuccess) {
      boxCubit.getBox(CourierOrderStatus.active);
    }
  }

  void onDone(BuildContext context, BoxModel box) {
    router.push(SignatureRoute(box: box));
  }

  Future<void> onCancel(BuildContext context, BoxModel box) async {
    await AppBottomSheet.showDefBottomSheet(context, Container());
  }
}
