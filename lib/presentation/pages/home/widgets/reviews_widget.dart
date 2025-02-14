import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/rating/rating_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: List.generate(5, (index) => ReviewCard()),
            ),
          )
        ],
      ),
    ));
  }
}

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Üst Bilgiler (Profil Resmi + Ad + Tarih + Puan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/200"),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: "John Doe",
                    textType: TextType.body,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    title: "12.01.2025",
                    textType: TextType.description,
                    color: Colors.grey,
                  ),
                ],
              ),
              const Spacer(),
              StarRating(rating: 4, size: 18),
            ],
          ),

          const SizedBox(height: 12),

          /// Yorum Metni
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: AppText(
              title:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              textType: TextType.body,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: AppText(
              title:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              textType: TextType.body,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),

          /// "Read More" Butonu
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
