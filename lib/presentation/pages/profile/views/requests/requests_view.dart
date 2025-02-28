import 'package:ase/data/bloc/request/request_cubit.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/card/request_card.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "RequestsRoute")
class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  final ScrollController scrollController = ScrollController();
  late final RequestCubit requestCubit;
  @override
  void dispose() {
    scrollController.dispose();
    requestCubit.close();
    requests.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    requestCubit = RequestCubit(OrderRepo());
    requestCubit.getRequests(1);
  }

  List<RequestModel> requests = [];
  int currentPage = 1;
  int totalPages = 1;

  void listener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          requestCubit.getRequests(currentPage);
        }
      }
    });
  }

  void updateProducts(List<RequestModel> newRequests) {
    final existingIds = requests.map((p) => p.id).toSet();
    requests.addAll(newRequests.where((p) => !existingIds.contains(p.id)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => requestCubit,
      child: Scaffold(
        body: RefreshIndicator.noSpinner(
          onRefresh: () async {
            requestCubit.getRequests(1, isRefresh: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              DefSliverAppBar(title: LocaleKeys.navigation_requests.tr()),
              BlocConsumer<RequestCubit, RequestState>(
                listener: (context, state) {
                  if (state is RequestLoaded) {
                    if (state.isRefresh) {
                      requests.clear();
                      currentPage = 1;
                    }
                    updateProducts(state.model.results ?? []);
                    totalPages = state.model.totalPages ?? 1;
                  }
                },
                builder: (context, state) {
                  if (state is RequestLoading && requests.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  } else if (requests.isEmpty) {
                    return SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          CustomAssetImage(
                              path: AssetConstants.empty.svg, isSvg: true),
                          AppText(
                              title: LocaleKeys.notification_not_found_requests
                                  .tr(),
                              textType: TextType.body),
                        ],
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList.separated(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return RequestCard(requestModel: request);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
