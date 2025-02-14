import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: LoadingAnimationWidget.twistingDots(
          leftDotColor: ColorConstants.darkGrey,
          rightDotColor: ColorConstants.primary,
          size: 50),
    );
  }
}
