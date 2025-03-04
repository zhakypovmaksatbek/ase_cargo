import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.status,
    required this.title,
    required this.statusTextFunction,
    required this.statusColorFunction,
    required this.statusIconFunction,
  });

  final String? status;
  final String title;
  final String Function(String) statusTextFunction;
  final Color Function(String) statusColorFunction;
  final String Function(String) statusIconFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        AppText(
          title: title,
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: CustomBoxDecoration()
                .copyWith(color: ColorConstants.lightSlate),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Flexible(
                  child: AppText(
                    title: statusTextFunction(status ?? "-"),
                    textType: TextType.subtitle,
                    fontWeight: FontWeight.w500,
                    color: statusColorFunction(status ?? "-"),
                  ),
                ),
                CustomAssetImage(
                  path: statusIconFunction(status ?? "-"),
                  isSvg: true,
                  svgColor: statusColorFunction(status ?? "-"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
