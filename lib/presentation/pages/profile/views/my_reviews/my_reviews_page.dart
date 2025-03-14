import 'package:ase/data/bloc/my_reviews/my_reviews_cubit.dart';
import 'package:ase/data/bloc/review_action/review_action_cubit.dart';
import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/card/detail_review_card.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:ase/presentation/widgets/empty/custom_empty_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "MyReviewsRoute")
class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  final ValueNotifier<List<ReviewModel>> reviews = ValueNotifier([]);
  late final MyReviewsCubit myReviewsCubit;
  late final ReviewActionCubit reviewActionCubit;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPage = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    myReviewsCubit = MyReviewsCubit();
    reviewActionCubit = ReviewActionCubit();
    myReviewsCubit.getMyReviews(page);
  }

  void listener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < totalPage && !isLoading) {
          page++;
          myReviewsCubit.getMyReviews(page);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    reviews.dispose();
    myReviewsCubit.close();
    reviewActionCubit.close();
    scrollController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: myReviewsCubit,
        child: BlocProvider.value(
          value: reviewActionCubit,
          child: BlocListener<ReviewActionCubit, ReviewActionState>(
            listener: (context, state) {
              if (state is ReviewDeleteSuccess) {
                final updatedReviews = List<ReviewModel>.from(reviews.value);
                updatedReviews
                    .removeWhere((element) => element.code == state.code);
                reviews.value = updatedReviews;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: Text(LocaleKeys.navigation_my_reviews.tr()),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await myReviewsCubit.getMyReviews(page);
                },
                child: CustomScrollView(slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: BlocListener<MyReviewsCubit, MyReviewsState>(
                      listener: (context, state) async {
                        if (state is MyReviewsSuccess) {
                          reviews.value = state.reviews.results ?? [];
                          totalPage = state.reviews.totalPages ?? 1;
                        }
                      },
                      child: ValueListenableBuilder<List<ReviewModel>?>(
                        valueListenable: reviews,
                        builder: (context, reviews, child) {
                          if (reviews?.isEmpty ?? true) {
                            return SliverFillRemaining(
                              child: CustomEmptyWidget(
                                  title: LocaleKeys
                                      .notification_you_have_not_reviewed_yet
                                      .tr(),
                                  svgImage: AssetConstants.myReview.svg),
                            );
                          }
                          return SliverList.separated(
                              itemBuilder: (context, index) {
                                final review = reviews?[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  decoration: CustomBoxDecoration().copyWith(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: ColorConstants.grey,
                                        width: 0.5,
                                      )),
                                  child: DetailReviewCard(
                                      isMyReview: true,
                                      review: review ?? ReviewModel(),
                                      onTap: () async {
                                        final bool? isConfirm =
                                            await AppDialogs.warningDialog(
                                                context,
                                                confirmTitle: LocaleKeys
                                                    .button_delete
                                                    .tr(),
                                                message: LocaleKeys
                                                    .notification_delete_review_description
                                                    .tr());
                                        if (isConfirm ?? false) {
                                          await reviewActionCubit
                                              .deleteReview(review?.code ?? "");
                                        }
                                      }),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: reviews?.length ?? 0);
                        },
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}
