// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/news/news_cubit.dart';
import 'package:ase/data/models/news_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/utils/date_time_utils.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "NewsRoute")
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsCubit newsCubit;
  late final ScrollController scrollController;
  int currentPage = 1;
  int totalCount = 3;
  bool isLoading = false;
  @override
  void initState() {
    scrollController = ScrollController()..addListener(listener);
    newsCubit = NewsCubit();
    newsCubit.getNews(currentPage);
    super.initState();
  }

  void listener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < totalCount) {
        if (!isLoading) {
          currentPage++;
          newsCubit.getNews(currentPage);
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    newsCubit.close();
    super.dispose();
  }

  List<NewsModel> news = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => newsCubit,
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              title: Text(LocaleKeys.general_news.tr()),
              leading: BackButton(
                style: CustomBoxDecoration.backButtonStyle(),
              ),
            ),
            BlocConsumer<NewsCubit, NewsState>(
              listener: (context, state) {
                if (state is NewsLoaded) {
                  isLoading = false;
                  news = [...news, ...state.news.results ?? []];
                } else if (state is NewsLoading) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }
              },
              builder: (context, state) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return NewsVerticalCard(
                      news: news[index],
                    );
                  },
                  childCount: news.length,
                ));
              },
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 60),
              sliver: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const SliverToBoxAdapter(
                        child: Center(child: LoadingWidget()));
                  } else {
                    return SliverToBoxAdapter();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsVerticalCard extends StatelessWidget {
  const NewsVerticalCard({
    super.key,
    required this.news,
  });
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => getIt<AppRouter>().push(
            NewsDetailRoute(image: news.image ?? "", slug: news.slug ?? "")),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            CashedImages(
              imageUrl: news.image ?? "",
              width: size.width,
              height: size.width * .4,
              imageRadius: 14,
            ),
            AppText(
              title: news.title ?? "",
              textType: TextType.body,
              fontWeight: FontWeight.w700,
            ),
            Row(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
