// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/profile_mixin.dart';
import 'package:ase/presentation/pages/profile/widgets/navigate_card.dart';
import 'package:ase/presentation/pages/profile/widgets/profile_app_bar.dart';
import 'package:ase/presentation/pages/profile/widgets/reques_card_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'ProfileRoute')
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfileMixin {
  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      ProfileAppBar(),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverToBoxAdapter(
          child: Column(
            spacing: 20,
            children: [
              const SizedBox(),
              RequestCardWidget(
                  icon: AssetConstants.request.svg,
                  title: LocaleKeys.navigation_requests.tr(),
                  backgroundColor: ColorConstants.primary,
                  textColor: ColorConstants.white,
                  activateTrailingWidget: true),
              RequestCardWidget(
                  icon: AssetConstants.history.svg,
                  title: LocaleKeys.navigation_order_history.tr(),
                  activateTrailingWidget: false),
              NavigateCard(),
              NavigateWithoutIconCard(
                navigateModel: appInfoNavigationList,
              ),
              NavigateWithoutIconCard(
                navigateModel: logoutNavigationList,
              ),
              const SizedBox(height: 60)
            ],
          ),
        ),
      )
    ]));
  }
}

class NavigateWithoutIconCard extends StatelessWidget {
  const NavigateWithoutIconCard({
    super.key,
    required this.navigateModel,
  });
  final List<NavigateModel> navigateModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: CustomBoxDecoration().copyWith(
        boxShadow: BoxDecorationValues.listTileBoxShadow,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: ColorConstants.dividerColor,
        ),
        itemCount: navigateModel.length,
        itemBuilder: (BuildContext context, int index) {
          final e = navigateModel[index];
          return _navigateTextButton(
              title: e.title,
              onTap: () => e.onTap!(context),
              textColor: e.textColor);
        },
      ),
    );
  }

  Padding _navigateTextButton(
      {void Function()? onTap, required String title, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: AppText(
          title: title,
          textType: TextType.body,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class NavigateModel {
  final String title;
  final Color? textColor;
  final void Function(BuildContext context)? onTap;

  NavigateModel({
    required this.title,
    this.onTap,
    this.textColor,
  });
}
