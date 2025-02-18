import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration extends BoxDecoration {
  CustomBoxDecoration()
      : super(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(16));

  static BoxDecoration circleDecoration() {
    return const BoxDecoration(
        shape: BoxShape.circle, color: ColorConstants.white);
  }

  static ButtonStyle backButtonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(ColorConstants.dividerColor),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))));
  }
}

class BoxDecorationValues {
  static final List<BoxShadow> defBoxShadow = [
    BoxShadow(
      color: ColorConstants.grey.withValues(alpha: 0.5),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 6),
    ),
  ];
  static final List<BoxShadow> listTileBoxShadow = [
    BoxShadow(
        color: ColorConstants.grey.withValues(alpha: .3),
        blurRadius: 14,
        spreadRadius: 0.5,
        offset: Offset(0, 0),
        blurStyle: BlurStyle.normal)
  ];
}
