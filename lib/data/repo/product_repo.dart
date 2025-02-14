import 'package:ase/data/models/banner_model.dart';
import 'package:ase/data/models/story_model.dart';

class ProductRepo {
  Future<HomeModel> getHomeData() async {
    return HomeModel(
      banners: [
        Banners(
          imageMobile: "https://picsum.photos/200/300",
          link: Link(
            link: "https://picsum.photos/200/300",
            name: "Lorem ipsum",
          ),
          title: "Lorem ipsum",
          type: "image",
        ),
        Banners(
          imageMobile: "https://picsum.photos/200/300",
          link: Link(
            link: "https://picsum.photos/200/300",
            name: "Lorem ipsum",
          ),
          title: "Lorem ipsum",
          type: "image",
        ),
      ],
    );
  }

  Future<List<StoryModel>> getStories() async {
    return [
      StoryModel(
        id: 1,
        image: "https://picsum.photos/200/300",
        viewed: false,
        title: "Story 1",
        stories: [
          Stories(
            image: "https://picsum.photos/200/300",
            type: "image",
            link: StoryLink(
                link: "https://picsum.photos/200/300", name: "Lorem ipsum"),
          ),
        ],
      ),
      StoryModel(
        id: 2,
        image: "https://picsum.photos/200/300",
        viewed: false,
        title: "Story 2",
        stories: [
          Stories(
            image: "https://picsum.photos/200/300",
            type: "image",
            link: StoryLink(
                link: "https://picsum.photos/200/300", name: "Lorem ipsum"),
          ),
        ],
      ),
    ];
  }

  Future<String> storyViewed(int storyId) async {
    return "";
  }
}
