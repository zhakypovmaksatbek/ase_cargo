// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/story_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class StoryScreenView extends StatelessWidget {
  StoryScreenView({
    super.key,
    // required this.stories,
    required this.storyList,
    required this.initialPage,
  });
  // final List<Stories> stories;
  final int initialPage;
  final List<StoryModel> storyList;
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: StoryPageView(
          initialPage: initialPage,
          backgroundColor: ColorConstants.backgroundLight,
          indicatorPadding: const EdgeInsets.only(top: 56),
          itemBuilder: (context, pageIndex, storyIndex) {
            final story = storyList[pageIndex];
            final stories = story.stories?[storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                    child: StoryImage(
                  /// key is required
                  key: ValueKey(stories?.image),
                  imageProvider: NetworkImage(
                    stories?.image ?? "",
                  ),
                  fit: BoxFit.fitWidth,
                )),
              ],
            );
          },
          pageLength: storyList.length,
          storyLength: (int pageIndex) {
            return storyList[pageIndex].stories?.length ?? 0;
          },
          onPageLimitReached: () {
            router.maybePop();
          },
        ),
      ),
    );
  }
}
