// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/divider/custom_divider.dart';
import 'package:flutter/material.dart';

class DefSliverAppBar extends StatelessWidget {
  const DefSliverAppBar({
    super.key,
    required this.title,
    this.pinned,
  });
  final String title;
  final bool? pinned;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned ?? true,
      title: Text(title),
      leading: BackButton(
        style: CustomBoxDecoration.backButtonStyle(),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: CustomDivider(horizontalPadding: 16),
      ),
    );
  }
}
