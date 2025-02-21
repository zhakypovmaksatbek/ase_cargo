import 'dart:ui';

import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static Future<bool?> warningDialog(BuildContext context,
      {String? confirmTitle, String? message}) {
    return showDialog<bool>(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: ColorConstants.white.withValues(alpha: .1),
              ),
            ),
            AlertDialog(
                iconPadding: const EdgeInsets.all(20),
                title: AppText(
                    title: message ?? LocaleKeys.notification_exit_account.tr(),
                    textAlign: TextAlign.center,
                    textType: TextType.body),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.router.maybePop(true);
                      },
                      style: ElevatedButton.styleFrom(
                          overlayColor: ColorConstants.white,
                          backgroundColor: ColorConstants.primary),
                      child: AppText(
                          title: confirmTitle ?? LocaleKeys.button_exit.tr(),
                          color: ColorConstants.white,
                          textType: TextType.body),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.router.maybePop(false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.dividerColor),
                      child: AppText(
                        title: LocaleKeys.button_cancel.tr(),
                        textType: TextType.body,
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }

  static Future<bool?> defaultDialog(
      BuildContext context, Widget? title, Color? buttonColor) {
    return showDialog<bool>(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: ColorConstants.white.withValues(alpha: .1),
              ),
            ),
            AlertDialog(
                iconPadding: const EdgeInsets.all(20),
                title: AppText(
                    title: LocaleKeys.notification_exit_account.tr(),
                    textAlign: TextAlign.center,
                    textType: TextType.body),
                content: ElevatedButton(
                  onPressed: () {
                    context.router.maybePop(true);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor ?? ColorConstants.primary),
                  child: AppText(
                      title: LocaleKeys.button_ok.tr(),
                      textType: TextType.body),
                )),
          ],
        );
      },
    );
  }
}
