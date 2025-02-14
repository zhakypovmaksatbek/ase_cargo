import 'package:ase/data/bloc/story/story_cubit.dart';
import 'package:ase/data/bloc/story_view/story_view_cubit.dart';
import 'package:ase/data/models/story_model.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/home/widgets/story_screen_view.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        if (state is StoryLoaded) {
          final stories = state.stories;
          return SliverPadding(
            padding: const EdgeInsets.only(top: 12.0, left: 16),
            sliver: SliverToBoxAdapter(
              child: stories.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: SizedBox(
                        height: 121,
                        child: ListView.builder(
                          itemCount: stories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return StoryCard(
                                initialPage: index,
                                storyList: stories,
                                stories: stories[index].stories ?? [],
                                story: stories[index]);
                          },
                        ),
                      ),
                    ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.stories,
    required this.story,
    required this.storyList,
    required this.initialPage,
  });
  final List<Stories> stories;
  final StoryModel story;
  final int initialPage;
  final List<StoryModel> storyList;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          if (story.stories != null && story.stories!.isNotEmpty) {
            showMaterialModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) => StoryScreenView(
                      // stories: stories,
                      storyList: storyList,
                      initialPage: initialPage,
                    ));
          }
        },
        child: Column(
          children: [
            statusStory(
              story.viewed ?? false,
              story.id!,
              theme,
              SizedBox(
                height: 88,
                width: 88,
                child: CashedImages(
                  imageUrl: story.image ?? "",
                  height: 88,
                  width: 88,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusStory(
      bool status, int productId, ThemeData theme, Widget child) {
    return BlocConsumer<StoryViewCubit, StoryViewState>(
        listener: (context, state) {
      if (state is StoryViewSuccess && state.storyId == productId) {
        status = state.response == 'Story checked successfully';
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Container(
            height: 88,
            width: 88,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color:
                        status ? ColorConstants.primary : ColorConstants.grey,
                    width: 3)),
            child: child,
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 88,
            child: AppText(
              title: story.title ?? "",
              textType: TextType.subtitle,
              color: status ? theme.hintColor : theme.iconTheme.color,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              maxLines: 1,
            ),
          )
        ],
      );
    });
  }
}
