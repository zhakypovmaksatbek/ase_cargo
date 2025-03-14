import 'package:ase/data/bloc/banner_bloc/banner_cubit.dart';
import 'package:ase/data/bloc/news/news_cubit.dart';
import 'package:ase/data/bloc/reviews/reviews_cubit.dart';
import 'package:ase/data/bloc/service/service_cubit.dart';
import 'package:ase/data/bloc/story/story_cubit.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/presentation/pages/home/widgets/banners_widget.dart';
import 'package:ase/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:ase/presentation/pages/home/widgets/news_widget.dart';
import 'package:ase/presentation/pages/home/widgets/our_services.dart';
import 'package:ase/presentation/pages/home/widgets/questions_widget.dart';
import 'package:ase/presentation/pages/home/widgets/reviews_widget.dart';
import 'package:ase/presentation/pages/home/widgets/stories_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "HomeRoute")
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _getHomeData();

    super.initState();
  }

  void _getHomeData() {
    context.read<StoryCubit>().getStories();
    context.read<BannerCubit>().getHomeData();
    context.read<NewsCubit>().getNews(1);
    context.read<ServiceCubit>().getService(1);
    context.read<UserCubit>().getUser();
    context.read<ReviewsCubit>().getReviews(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getHomeData();
        },
        child: CustomScrollView(
          slivers: [
            HomeAppBar(),

            /// MARK: Stories
            const StoriesWidget(),

            /// MARK: Banners
            BannersWidget(),

            /// MARK: News
            const NewsWidget(),

            /// MARK: Our services
            const OurServicesWidget(),

            /// MARK: Reviews
            const ReviewsWidget(),

            /// MARK: Questions
            const QuestionsWidget(),
          ],
        ),
      ),
    );
  }
}
