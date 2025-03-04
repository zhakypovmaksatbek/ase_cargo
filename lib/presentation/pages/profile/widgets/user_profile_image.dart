// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.avatar,
    this.size,
  });
  final String avatar;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 100,
      width: size ?? 100,
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstants.lightGrey,
      ),
      child: CashedImages(
        imageUrl: avatar,
        borderRadius: BorderRadius.circular(50),
        fit: BoxFit.cover,
      ),
    );
  }
}
