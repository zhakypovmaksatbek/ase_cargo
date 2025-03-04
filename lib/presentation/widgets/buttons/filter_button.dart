import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: CustomBoxDecoration()
            .copyWith(boxShadow: BoxDecorationValues.listTileBoxShadow),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Icon(Icons.tune_rounded),
            AppText(
                title: LocaleKeys.button_filters.tr(), textType: TextType.body)
          ],
        ),
      ),
    );
  }
}
