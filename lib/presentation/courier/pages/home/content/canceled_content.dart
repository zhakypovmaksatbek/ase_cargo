// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/courier/widgets/card/c_order_card.dart';
import 'package:ase/presentation/widgets/error/custom_error_widget.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanceledTabContent extends StatefulWidget {
  const CanceledTabContent({
    super.key,
  });

  @override
  State<CanceledTabContent> createState() => _CanceledTabContentState();
}

class _CanceledTabContentState extends State<CanceledTabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  List<BoxModel> boxList = [];

  void initData() {
    context.read<BoxCubit>().getBox(CourierOrderStatus.cancelled);
  }

  Future<void> refreshData() async {
    await context
        .read<BoxCubit>()
        .getBox(CourierOrderStatus.cancelled, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<BoxCubit, BoxState>(
      listener: cancelledBoxListener,
      builder: (context, state) {
        if (state is BoxLoading && boxList.isEmpty) {
          return Center(child: const LoadingWidget());
        } else if (state is BoxError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomErrorWidget(message: state.message),
              ElevatedButton(
                  onPressed: refreshData,
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
                  onPressed: refreshData,
                  child: Text(LocaleKeys.button_refresh.tr())),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: boxList.length + 1,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                if (index == boxList.length) {
                  return SizedBox(height: 60);
                }
                final box = boxList[index];
                return COrderCard(
                  box: box,
                  isCanceled: true,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void cancelledBoxListener(context, state) {
    if (state is BoxLoaded) {
      if (state.isRefresh && state.status == CourierOrderStatus.cancelled) {
        boxList.clear();
      }
      if (state.status == CourierOrderStatus.cancelled) {
        boxList.addAll(state.box.results ?? []);
      }
    }
  }

  final router = getIt<AppRouter>();
  void onDone(BuildContext context, BoxModel box) {
    router.push(SignatureRoute(box: box));
  }
}
