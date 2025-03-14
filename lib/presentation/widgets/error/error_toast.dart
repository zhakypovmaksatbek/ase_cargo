import 'package:ase/generated/locale_keys.g.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorToast {
  static void defExceptionToast(BuildContext context, String message) {
    CherryToast.error(
      title: Text(LocaleKeys.exception_exception.tr()),
      description: Text(message),
      animationType: AnimationType.fromTop,
    ).show(context);
  }

  static void defSuccessToast(BuildContext context, String message) {
    CherryToast.success(
      title: Text(LocaleKeys.notification_success.tr()),
      description: Text(message),
      animationType: AnimationType.fromTop,
    ).show(context);
  }
}
