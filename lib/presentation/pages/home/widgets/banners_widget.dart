// ignore_for_file: must_be_immutable

import 'package:ase/data/bloc/banner_bloc/banner_cubit.dart';
import 'package:ase/data/models/banner_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key});

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  List<BannerModel>? banners = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) async {
        if (state is BannerLoaded) {
          banners = state.data;
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
              height: size.width * .35,
              child: PageView.builder(
                  itemCount: banners?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final banner = banners?[index];
                    return CashedImages(
                        imageUrl: banner?.image ?? "",
                        width: size.width,
                        borderRadius: BorderRadius.circular(14),
                        fit: BoxFit.cover,
                        height: 132);
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
}
