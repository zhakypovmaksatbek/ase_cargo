import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.textSpans,
  });

  final List<RichTextSpan> textSpans;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: textSpans
            .map((span) => TextSpan(
                  text: span.text,
                  style: getTextStyle(span.textType).copyWith(
                    color: span.color,
                    fontWeight: span.fontWeight,
                    decoration: span.decoration,
                  ),
                ))
            .toList(),
      ),
    );
  }

  TextStyle getTextStyle(TextType type) {
    switch (type) {
      case TextType.header:
        return const TextStyle(
          color: ColorConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
      case TextType.body:
        return const TextStyle(
          color: ColorConstants.darkGrey,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
      case TextType.title:
        return const TextStyle(
            color: ColorConstants.black,
            fontWeight: FontWeight.w700,
            fontSize: 22);
      case TextType.title20:
        return const TextStyle(color: ColorConstants.black, fontSize: 20);
      case TextType.title24:
        return const TextStyle(color: ColorConstants.black, fontSize: 26);
      case TextType.subtitle:
        return const TextStyle(
            color: ColorConstants.black,
            fontWeight: FontWeight.w400,
            fontSize: 14);
      case TextType.description:
        return const TextStyle(
            color: ColorConstants.white,
            fontWeight: FontWeight.w400,
            fontSize: 12);
    }
  }
}

class RichTextSpan {
  final String text;
  final TextType textType;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  RichTextSpan({
    required this.text,
    required this.textType,
    this.color,
    this.fontWeight,
    this.decoration,
  });
}
