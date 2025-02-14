import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration extends BoxDecoration {
  CustomBoxDecoration()
      : super(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(16));

  static BoxDecoration bodyContainerDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: ColorConstants.white);
  }
}

class BoxDecorationValues {
  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: ColorConstants.grey.withValues(alpha: 0.5),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 6),
    ),
  ];
}
