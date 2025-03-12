import 'package:ase/data/bloc/order_history/order_history_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/courier/widgets/card/history_order_card.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'COrderHistoryRoute')
class COrderHistoryPage extends StatefulWidget {
  const COrderHistoryPage({super.key});

  @override
  State<COrderHistoryPage> createState() => _COrderHistoryPageState();
}

class _COrderHistoryPageState extends State<COrderHistoryPage> {
  late final OrderHistoryCubit orderHistoryCubit;
  late final ScrollController scrollController;
  int page = 1;
  bool isLoading = false;
  int totalPages = 1;
  List<BoxModel> orders = [];
  @override
  void initState() {
    super.initState();
    orderHistoryCubit = OrderHistoryCubit();
    scrollController = ScrollController()..addListener(listener);
    orderHistoryCubit.getOrderHistory(page);
  }

  void listener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (page < totalPages && !isLoading) {
        page++;
        orderHistoryCubit.getOrderHistory(page);
      }
    }
  }

  @override
  void dispose() {
    orderHistoryCubit.close();
    orders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: orderHistoryCubit,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            page = 1;
            orders.clear();
            orderHistoryCubit.getOrderHistory(page);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              DefSliverAppBar(title: LocaleKeys.navigation_order_history.tr()),
              BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
                listener: (context, state) {
                  if (state is OrderHistoryLoaded) {
                    isLoading = false;
                    totalPages = state.data.totalPages ?? 1;
                    orders.addAll(state.data.results ?? []);
                  } else if (state is OrderHistoryLoading) {
                    isLoading = true;
                  } else {
                    isLoading = false;
                  }
                },
                builder: (context, state) {
                  if (state is OrderHistoryLoading && orders.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: LoadingWidget()),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList.separated(
                      itemCount: orders.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return HistoryOrderCard(order: order);
                      },
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: const SizedBox(height: 60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
