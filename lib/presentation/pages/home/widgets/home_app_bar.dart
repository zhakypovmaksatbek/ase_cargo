import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      title: Text("Hello, User"),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          backgroundColor: ColorConstants.lightGrey,
          child: CustomAssetImage(
            height: 30,
            width: 30,
            path: AssetConstants.profileImage.svg,
            isSvg: true,
          ),
        ),
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
            isSvg: true,
          ),
        ),
      ],
    );
  }
}
