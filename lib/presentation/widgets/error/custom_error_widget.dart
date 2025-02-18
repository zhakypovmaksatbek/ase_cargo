import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomAssetImage(
          path: AssetConstants.error.svg,
          isSvg: true,
        ),
        AppText(
          title: message,
          textType: TextType.body,
        )
      ],
    );
  }
}
