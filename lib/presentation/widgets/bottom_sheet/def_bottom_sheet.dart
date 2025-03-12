import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final class AppBottomSheet {
  static final router = getIt<AppRouter>();

  static Future<void> showDefBottomSheet(
      BuildContext context, Widget child) async {
    await showBarModalBottomSheet(
      context: context,
      bounce: true,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(14),
      ),
      barrierColor: ColorConstants.black.withValues(alpha: .4),
      builder: (context) => child,
      backgroundColor: Colors.white,
    );
  }

  static Future<void> showCupertinoBottomSheet(
      BuildContext context, Widget child,
      {required void Function() firstActionTap,
      required void Function() secondActionTap,
      String? title,
      String? message}) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: title != null ? Text(title) : null,
        message: message != null ? Text(message) : null,
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              router.maybePop();
              firstActionTap();
            },
            child: const Text("Kameradan Çek"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              router.maybePop();
              secondActionTap();
            },
            child: const Text("Galeriden Seç"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => getIt<AppRouter>().maybePop(),
          isDestructiveAction: true,
          child: Text(LocaleKeys.button_cancel.tr()),
        ),
      ),
    );
  }
}
