import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DefElevatedButton extends StatelessWidget {
  const DefElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.verticalPadding,
    this.horizontalPadding,
    this.radius,
  });
  final String text;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primary,
        overlayColor: ColorConstants.white,
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 12,
            horizontal: horizontalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 14),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
