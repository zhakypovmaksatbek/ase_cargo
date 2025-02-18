import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/profile_page.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

mixin ProfileMixin on State<ProfilePage> {
  final List<NavigateModel> appInfoNavigationList = [
    NavigateModel(
      title: LocaleKeys.navigation_aboutApp.tr(),
      onTap: (context) {},
    ),
    NavigateModel(
      title: LocaleKeys.navigation_termsOfUse.tr(),
      onTap: (context) {},
    ),
  ];
  final List<NavigateModel> logoutNavigationList = [
    NavigateModel(
      title: LocaleKeys.button_logout.tr(),
      onTap: (context) async {
        await AppDialogs.warningDialog(context);
      },
    ),
    NavigateModel(
        title: LocaleKeys.button_delete_account.tr(),
        onTap: (context) {},
        textColor: ColorConstants.red),
  ];
}
