import 'dart:ui';

import 'package:ase/data/bloc/reviews/reviews_cubit.dart';
import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/card/detail_review_card.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "ViewsRoute")
class ViewsPage extends StatefulWidget {
  const ViewsPage({super.key});

  @override
  State<ViewsPage> createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  late final ReviewsCubit reviewCubit;
  late final ScrollController scrollController;
  int page = 1;
  bool isLoading = false;
  int totalPage = 1;
  List<ReviewModel> reviews = [];
  @override
  void initState() {
    reviewCubit = ReviewsCubit();
    reviewCubit.getReviews(page);
    scrollController = ScrollController()..addListener(listen);
    super.initState();
  }

  void listen() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < totalPage && !isLoading) {
          page++;
          reviewCubit.getReviews(page);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    reviewCubit.close();
    scrollController.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: reviewCubit,
      child: Scaffold(
          body: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        trackVisibility: false,
        child: CustomScrollView(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          slivers: [
            DefSliverAppBar(title: LocaleKeys.general_reviews.tr()),
            BlocConsumer<ReviewsCubit, ReviewsState>(
              listener: (context, state) {
                if (state is ReviewsSuccess) {
                  totalPage = state.reviews.totalPages ?? 1;
                  reviews.addAll(state.reviews.results ?? []);
                }
              },
              builder: (context, state) {
                return SliverList.separated(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  separatorBuilder: (context, index) => const Divider(
                    color: ColorConstants.dividerColor,
                  ),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) => DetailReviewCard(
                    review: reviews[index],
                  ),
                );
              },
            ),
            BlocBuilder<ReviewsCubit, ReviewsState>(
              builder: (context, state) {
                if (state is ReviewsLoading && reviews.isNotEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: LoadingWidget()),
                  );
                }
                return SliverToBoxAdapter();
              },
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 60))
          ],
        ),
      )),
    );
  }
}
