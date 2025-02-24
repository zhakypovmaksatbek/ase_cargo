import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      title: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            return Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: ColorConstants.lightGrey,
                  child: CashedImages(
                    imageUrl: state.user.avatar ?? "",
                    isUser: true,
                    isSvg: true,
                    height: 25,
                    width: 25,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Hello ${state.user.firstName ?? ""}👋🏻",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: LoadingWidget(),
            );
          }
        },
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorConstants.grey)),
          child: CustomAssetImage(
            path: AssetConstants.notification.svg,
            svgColor: ColorConstants.primary,
            isSvg: true,
          ),
        ),
      ],
    );
  }
}
