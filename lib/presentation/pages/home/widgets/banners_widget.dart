// ignore_for_file: must_be_immutable

import 'package:ase/data/bloc/banner_bloc/banner_cubit.dart';
import 'package:ase/data/models/banner_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BannersWidget extends StatelessWidget {
  BannersWidget({super.key});
  List<Banners>? banners = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) async {
        if (state is BannerLoaded) {
          banners = state.data.banners;
        }
      },
      builder: (context, state) {
        if (banners?.isNotEmpty ?? false) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            sliver: SliverToBoxAdapter(
                child: SizedBox(
              height: 132,
              child: PageView.builder(
                  itemCount: banners?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final banner = banners?[index];
                    return InkWell(
                      onTap: () async {
                        await _navigate(banner);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: CashedImages(
                          imageUrl: banner?.imageMobile ?? "",
                          width: size.width,
                          borderRadius: BorderRadius.circular(14),
                          fit: BoxFit.cover,
                          height: 132),
                    );
                  }),
            )),
          );
        } else {
          return const SliverToBoxAdapter();
        }
      },
    );
  }

  final router = getIt<AppRouter>();
  Future<void> _navigate(Banners? banner) async {
    switch (banner?.type) {
      case "link":
        if (banner?.link?.link != null && banner?.link?.link != "") {
          await launchUrl(Uri.parse(banner!.link!.link!));
        }
        break;

      case "product":
        if (banner?.link?.link != null) {
          // router
          //     .push(DynamicProductDetailRoute(productId: banner!.link!.link!));
        }
      case "category":
        if (banner?.link?.link != null) {
          // router.push(ProductsRoute(
          //     image: banner?.imageMobile ?? "",
          //     category: CategoryModel(
          //       id: banner?.link?.link,
          //       title: "",
          //     )));
        }
      default:
    }
  }
}
