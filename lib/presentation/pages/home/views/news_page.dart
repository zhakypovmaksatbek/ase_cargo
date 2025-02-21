import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "NewsRoute")
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(LocaleKeys.general_news.tr()),
            leading: BackButton(
              style: CustomBoxDecoration.backButtonStyle(),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return NewsVerticalCard();
            },
          ))
        ],
      ),
    );
  }
}

class NewsVerticalCard extends StatelessWidget {
  const NewsVerticalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => getIt<AppRouter>().push(NewsDetailRoute()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            CashedImages(
              imageUrl: "https://picsum.photos/200",
              width: size.width,
              height: size.width * .4,
              imageRadius: 14,
            ),
            AppText(
              title: "Отслеживание, скорость и надёжность в одном приложении",
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
                  title: "12/01/25",
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
