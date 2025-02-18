import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.horizontalPadding = 0,
  });
  final double horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(
        color: ColorConstants.dividerColor,
      ),
    );
  }
}
