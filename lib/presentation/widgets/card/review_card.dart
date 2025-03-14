import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/utils/date_time_utils.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/rating/rating_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.review});
  final ReviewModel review;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isExpanded = false;
  void toggleExpanded() {
    AppBottomSheet.showDefBottomSheet(
        context,
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.review.author?.avatar ?? ""),
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: widget.review.author?.name ?? "",
                        textType: TextType.body,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        title: DateTimeUtils.formatDate(
                            widget.review.createdAt ?? ""),
                        textType: TextType.description,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Spacer(),
                  StarRating(rating: widget.review.rating ?? 0, size: 18),
                ],
              ),
              if (widget.review.comment != null)
                AppText(
                  title: widget.review.comment ?? "",
                  textType: TextType.body,
                ),
              if (widget.review.image?.isNotEmpty ?? false)
                CashedImages(imageUrl: widget.review.image ?? ""),
              const SizedBox(height: 32),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.review.author?.avatar ?? ""),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: widget.review.author?.name ?? "",
                    textType: TextType.body,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    title:
                        DateTimeUtils.formatDate(widget.review.createdAt ?? ""),
                    textType: TextType.description,
                    color: Colors.grey,
                  ),
                ],
              ),
              const Spacer(),
              StarRating(rating: widget.review.rating ?? 0, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          AppText(
            title: widget.review.comment ?? "",
            textType: TextType.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: toggleExpanded,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppText(
                title: LocaleKeys.button_read_more.tr(),
                textType: TextType.body,
                color: ColorConstants.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
