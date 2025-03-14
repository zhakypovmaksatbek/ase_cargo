import 'package:ase/data/bloc/reviews/reviews_cubit.dart';
import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/widgets/card/review_card.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key});
  static final router = getIt.get<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsSuccess) {
          final List<ReviewModel>? reviews = state.reviews.results;
          if (reviews == null || reviews.isEmpty) {
            return const SliverToBoxAdapter();
          }
          return SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                        title: LocaleKeys.general_read_reviews.tr(),
                        textType: TextType.title),
                    GestureDetector(
                        onTap: () => router.push(const ViewsRoute()),
                        child: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: List.generate(reviews.length,
                        (index) => ReviewCard(review: reviews[index])),
                  ),
                )
              ],
            ),
          ));
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
