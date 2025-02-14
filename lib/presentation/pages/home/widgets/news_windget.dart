import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

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
                  title: LocaleKeys.general_news.tr(),
                  textType: TextType.title),
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: [
                ...List.generate(
                  10,
                  (index) => NewsCard(),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          CashedImages(
            imageUrl: "https://picsum.photos/200/300",
            fit: BoxFit.cover,
            width: size.width * 0.8,
            borderRadius: BorderRadius.circular(14),
            height: 132,
          ),
          AppText(
            title: "Отслеживание, скорость и надёжность в одном приложении",
            textType: TextType.body,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              CustomAssetImage(
                path: AssetConstants.date.svg,
                isSvg: true,
              ),
              AppText(
                  title: "12/01/25",
                  textType: TextType.subtitle,
                  color: ColorConstants.grey,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ],
      ),
    );
  }
}
