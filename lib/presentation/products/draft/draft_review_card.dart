import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/utils/date_time_utils.dart';
import 'package:ase/presentation/widgets/rating/rating_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DraftReviewCard extends StatefulWidget {
  const DraftReviewCard({super.key, required this.review});
  final ReviewModel review;

  @override
  State<DraftReviewCard> createState() => _DraftReviewCardState();
}

class _DraftReviewCardState extends State<DraftReviewCard> {
  bool isExpanded = false;
  void toggleExpanded() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: AppText(
              title: widget.review.comment ?? "",
              textType: TextType.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: AppText(
              title: widget.review.comment ?? "",
              textType: TextType.body,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
          GestureDetector(
            onTap: toggleExpanded,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppText(
                title: isExpanded
                    ? LocaleKeys.button_read_less.tr()
                    : LocaleKeys.button_read_more.tr(),
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
