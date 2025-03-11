// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/news/news_cubit.dart';
import 'package:ase/data/models/news_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/utils/date_time_utils.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<NewsModel> news = [];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsLoaded) {
            news = state.news.results ?? [];
          }
        },
        builder: (context, state) {
          if (news.isEmpty) {
            return SizedBox();
          } else {
            return Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                        title: LocaleKeys.general_news.tr(),
                        textType: TextType.title),
                    GestureDetector(
                        onTap: () => getIt<AppRouter>().push(NewsRoute()),
                        child: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        news.length,
                        (index) => NewsCard(
                          news: news[index],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    ));
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });
  static final router = getIt<AppRouter>();
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => router.push(
          NewsDetailRoute(image: news.image ?? "", slug: news.slug ?? "")),
      child: SizedBox(
        width: size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            CashedImages(
              imageUrl: news.image ?? "",
              fit: BoxFit.cover,
              width: size.width * 0.8,
              borderRadius: BorderRadius.circular(14),
              height: 142,
            ),
            AppText(
              title: news.title ?? "",
              textType: TextType.body,
              fontWeight: FontWeight.w700,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomAssetImage(
                  path: AssetConstants.date.svg,
                  isSvg: true,
                ),
                AppText(
                    title: DateTimeUtils.formatDate(news.createdAt ?? ""),
                    textType: TextType.subtitle,
                    color: ColorConstants.grey,
                    fontWeight: FontWeight.w400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
