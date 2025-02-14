import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstants.lightGrey,
      ),
      child: CustomAssetImage(
        path: AssetConstants.profileImage.svg,
        isSvg: true,
        svgColor: ColorConstants.grey,
      ),
    );
  }
}
