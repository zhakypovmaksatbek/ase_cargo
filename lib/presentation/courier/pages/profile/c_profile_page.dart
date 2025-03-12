import 'package:ase/core/app_manager.dart';
import 'package:ase/core/dio_settings.dart';
import 'package:ase/core/token_interceptor.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/profile_page.dart';
import 'package:ase/presentation/pages/profile/widgets/navigate_card.dart';
import 'package:ase/presentation/pages/profile/widgets/profile_app_bar.dart';
import 'package:ase/presentation/pages/profile/widgets/request_card_widget.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'CProfileRoute')
class CProfilePage extends StatefulWidget {
  const CProfilePage({super.key});

  @override
  State<CProfilePage> createState() => _CProfilePageState();
}

class _CProfilePageState extends State<CProfilePage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    context.read<UserCubit>().getUser();
  }

  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProfileAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: 20,
                children: [
                  const SizedBox(),
                  RequestCardWidget(
                    icon: AssetConstants.history.svg,
                    title: LocaleKeys.navigation_order_history.tr(),
                    backgroundColor: ColorConstants.primary,
                    textColor: ColorConstants.white,
                    onTap: () {
                      router.push(COrderHistoryRoute());
                    },
                  ),
                  NavigateCard(isCourier: true),
                  NavigateWithoutIconCard(
                    navigateModel: logoutNavigationList,
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<NavigateModel> logoutNavigationList = [
    NavigateModel(
      title: LocaleKeys.button_logout.tr(),
      onTap: (context) async {
        final bool? isExit = await AppDialogs.warningDialog(context);
        if (isExit ?? false) {
          await AppManager.instance.clearTokens();
          if (context.mounted) {
            context.read<UserCubit>().getUser();
          }
        }
      },
    ),
    NavigateModel(
        title: LocaleKeys.button_delete_account.tr(),
        onTap: (context) async {
          await TokenInterceptor(tokenDio: DioSettings().dio)
              .testRefreshToken();
        },
        textColor: ColorConstants.red),
  ];
}
