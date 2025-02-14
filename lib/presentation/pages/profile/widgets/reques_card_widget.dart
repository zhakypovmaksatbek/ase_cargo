// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({
    super.key,
    this.backgroundColor = ColorConstants.white,
    this.textColor,
    this.activateTrailingWidget = false,
    required this.title,
    required this.icon,
  });
  final Color? backgroundColor;
  final Color? textColor;
  final bool? activateTrailingWidget;
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: CustomBoxDecoration().copyWith(
          color: backgroundColor,
          boxShadow: BoxDecorationValues.listTileBoxShadow),
      child: Row(
        children: [
          CustomAssetImage(
            path: icon,
            isSvg: true,
            svgColor: textColor,
          ),
          const SizedBox(width: 10),
          AppText(
            title: title,
            textType: TextType.header,
            color: textColor ?? ColorConstants.lightBlack,
          ),
          const Spacer(),
          if (activateTrailingWidget!)
            AppText(
              title: "20",
              textType: TextType.body,
              fontWeight: FontWeight.w600,
              color: textColor,
            )
        ],
      ),
    );
  }
}
