// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/utils/date_time_utils.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/rating/rating_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailReviewCard extends StatelessWidget {
  const DetailReviewCard({
    super.key,
    this.isMyReview = false,
    required this.review,
    this.onTap,
  });
  final bool isMyReview;
  final ReviewModel review;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(review.author?.avatar ?? "")),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: review.author?.name ?? "",
                      textType: TextType.body,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      title: DateTimeUtils.formatDate(review.createdAt ?? ""),
                      textType: TextType.description,
                    ),
                  ],
                ),
              ),
              StarRating(
                rating: review.rating ?? 0,
                size: 14,
              )
            ],
          ),
          if (review.image != null)
            CashedImages(
                width: size.width,
                height: size.width / 2,
                imageUrl: review.image ?? ""),
          AppText(
            title: review.comment ?? "",
            textType: TextType.body,
          ),
          if (isMyReview)
            GestureDetector(
              onTap: onTap,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    AppText(
                      title: LocaleKeys.button_delete.tr(),
                      textType: TextType.body,
                      color: ColorConstants.darkGrey,
                    ),
                    CustomAssetImage(
                      path: AssetConstants.delete.svg,
                      isSvg: true,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
