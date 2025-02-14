import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.color = ColorConstants.yellow,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: List.generate(5, (index) {
        if (index >= rating) {
          return SvgPicture.asset(
            AssetConstants.ratingStar.svg,
            height: size,
          );
        } else if (index + 1 > rating && index < rating) {
          return SvgPicture.asset(
            AssetConstants.ratingStar.svg,
            height: size,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          );
        } else {
          return SvgPicture.asset(
            AssetConstants.ratingStar.svg,
            height: size,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          );
        }
      }),
    );
  }
}
