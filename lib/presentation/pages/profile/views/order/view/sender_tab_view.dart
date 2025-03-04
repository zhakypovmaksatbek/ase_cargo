// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/order/order_cubit.dart';
import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:ase/presentation/pages/profile/views/order/options/order_options.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/filter_bottom_sheet.dart';
import 'package:ase/presentation/widgets/buttons/filter_button.dart';
import 'package:ase/presentation/widgets/card/order_card.dart';
import 'package:ase/presentation/widgets/error/custom_error_widget.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenderTabView extends StatefulWidget {
  const SenderTabView({super.key});

  @override
  State<SenderTabView> createState() => _SenderTabViewState();
}

class _SenderTabViewState extends State<SenderTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<OrderModel> orders = [];
  late final ScrollController _controller;
  late final OrderCubit cubit;
  int currentPage = 1;
  int totalPage = 1;
  bool isLoading = false;
  OrderStatus? selectedStatus;
  @override
  void initState() {
    cubit = OrderCubit(OrderRepo());
    cubit.getOrder(1);
    _controller = ScrollController()..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (currentPage < totalPage) {
        if (!isLoading) {
          currentPage++;
          getOrder();
        }
      }
    }
  }

  void getOrder({bool? isRefresh = false}) {
    cubit.getOrder(
      currentPage,
      status: selectedStatus,
      isRefresh: isRefresh,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoaded) {
            orders.addAll(state.model.results ?? []);
          }
        },
        builder: (context, state) {
          if (state is OrderLoading && orders.isEmpty) {
            return Center(child: LoadingWidget());
          } else if (state is OrderError) {
            return Center(child: CustomErrorWidget(message: state.message));
          } else {
            return Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FilterButton(onTap: () async {
                    selectedStatus = await AppBottomSheet().filterBottomSheet(
                      context: context,
                      selectedValue: selectedStatus,
                      titleBuilder: (value) => value.name,
                      values: OrderStatus.values,
                    );
                    if (selectedStatus != null) {
                      currentPage = 1;
                      orders.clear();

                      getOrder(isRefresh: true);
                    }
                  }),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      currentPage = 1;
                      selectedStatus = null;
                      orders.clear();
                      getOrder(isRefresh: true);
                    },
                    child: ListView.separated(
                      controller: _controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: orders.length,
                      padding: EdgeInsets.only(bottom: 60, left: 16, right: 16),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderCard(order: order);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
