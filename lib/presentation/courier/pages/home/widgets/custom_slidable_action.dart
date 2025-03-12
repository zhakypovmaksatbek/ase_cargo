import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_plus_plus/flutter_slidable_plus_plus.dart';

class MyCustomSlidableAction extends StatelessWidget {
  const MyCustomSlidableAction({
    super.key,
    this.onPressed,
    required this.label,
    this.backgroundColor,
    required this.icon,
  });
  final void Function(BuildContext)? onPressed;
  final String label;
  final Color? backgroundColor;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SlidableAction(
        onPressed: onPressed,
        autoClose: true,
        borderRadius: BorderRadius.circular(10),
        backgroundColor: backgroundColor ?? ColorConstants.green,
        foregroundColor: Colors.white,
        spacing: 8,
        key: ValueKey(label),
        flex: 1,
        icon: icon,
        label: label);
  }
}
