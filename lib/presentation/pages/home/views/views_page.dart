import 'dart:ui';

import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/card/detail_review_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "ViewsRoute")
class ViewsPage extends StatefulWidget {
  const ViewsPage({super.key});

  @override
  State<ViewsPage> createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Scrollbar(
      thumbVisibility: true,
      interactive: true,
      trackVisibility: false,
      child: CustomScrollView(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        slivers: [
          DefSliverAppBar(title: LocaleKeys.general_reviews.tr()),
          SliverList.separated(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            separatorBuilder: (context, index) => const Divider(
              color: ColorConstants.dividerColor,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => DetailReviewCard(size: size),
          ),
          SliverPadding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom))
        ],
      ),
    ));
  }
}
