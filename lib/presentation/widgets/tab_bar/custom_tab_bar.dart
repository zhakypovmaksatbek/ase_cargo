import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: CustomBoxDecoration().copyWith(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
          labelPadding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelColor: ColorConstants.white,
          unselectedLabelColor: ColorConstants.grey,
          indicator: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          splashBorderRadius: BorderRadius.circular(14),
          overlayColor: WidgetStateProperty.all(ColorConstants.primary),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: controller,
          tabs: tabs),
    );
  }
}
