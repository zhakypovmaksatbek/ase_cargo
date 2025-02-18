import 'package:ase/core/app_manager.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/profile_page.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ProfileMixin on State<ProfilePage> {
  void initData(BuildContext context) {
    context.read<UserCubit>().getUser();
  }

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
        final bool? isExit = await AppDialogs.warningDialog(context);
        if (isExit ?? false) {
          await AppManager.instance.setToken(accessToken: '');
          await AppManager.instance.setIsLogin(false);
          if (context.mounted) {
            context.read<UserCubit>().getUser();
          }
        }
      },
    ),
    NavigateModel(
        title: LocaleKeys.button_delete_account.tr(),
        onTap: (context) {},
        textColor: ColorConstants.red),
  ];
}
