import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    required this.title,
    required this.svgImage,
  });
  final String title;
  final String svgImage;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        CustomAssetImage(path: svgImage, isSvg: true, height: 50),
        AppText(title: title, textType: TextType.body),
      ],
    ));
  }
}
