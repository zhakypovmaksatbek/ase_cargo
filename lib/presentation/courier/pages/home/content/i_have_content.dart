// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/bloc/update_order_status/update_order_status_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/courier/pages/home/widgets/cancel_content_widget.dart';
import 'package:ase/presentation/courier/pages/home/widgets/custom_slidable_action.dart';
import 'package:ase/presentation/courier/widgets/card/c_order_card.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/error/custom_error_widget.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
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
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData({bool isRefresh = false}) async {
    await context
        .read<BoxCubit>()
        .getBox(CourierOrderStatus.active, isRefresh: isRefresh);
  }

  final router = getIt<AppRouter>();
  List<BoxModel> boxList = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<BoxCubit, BoxState>(
      listener: _activeBoxListener,
      builder: (context, state) {
        if (state is BoxLoading && boxList.isEmpty) {
          return const Center(child: LoadingWidget());
        } else if (state is BoxError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomErrorWidget(message: state.message),
              ElevatedButton(
                  onPressed: () => initData(isRefresh: true),
                  child: Text(LocaleKeys.button_refresh.tr())),
            ],
          );
        } else if (boxList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(LocaleKeys.notification_not_found_order.tr()),
              ElevatedButton(
                  onPressed: () => initData(isRefresh: true),
                  child: Text(LocaleKeys.button_refresh.tr())),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () async => await initData(isRefresh: true),
          child: BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
            listener: updateOrderStatusListener,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                controller: _controller,
                itemCount: boxList.length + 1,
                physics: AlwaysScrollableScrollPhysics(),
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
                        // startActionPane: ActionPane(
                        //     motion: const ScrollMotion(),
                        //     extentRatio: 0.35,
                        //     children: [
                        //       MyCustomSlidableAction(
                        //         onPressed: (context) => onCancel(context, box),
                        //         icon: Icon(Icons.cancel_outlined),
                        //         backgroundColor: ColorConstants.red,
                        //         label: LocaleKeys.button_cancel.tr(),
                        //       ),
                        //     ]),
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
    );
  }

  void _activeBoxListener(context, state) {
    if (state is BoxLoaded && state.status == CourierOrderStatus.active) {
      if (state.isRefresh) {
        boxList.clear();
      }
      if (state.status == CourierOrderStatus.active) {
        boxList.addAll(state.box.results ?? []);
      }
    }
  }

  void updateOrderStatusListener(
      BuildContext context, UpdateOrderStatusState state) {
    if (state is UpdateOrderStatusSuccess) {
      context.read<BoxCubit>().getBox(CourierOrderStatus.active);
    }
  }

  void onDone(BuildContext context, BoxModel box) {
    router.push(SignatureRoute(box: box));
  }

  Future<void> onCancel(BuildContext context, BoxModel box) async {
    await AppBottomSheet.showDefBottomSheet(
        context, CancelContentWidget(box: box));
  }
}
