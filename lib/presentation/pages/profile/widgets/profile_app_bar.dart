import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/widgets/user_profile_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
          children: [
            UserProfileImage(),
            Column(
              children: [
                AppText(
                  title: "Александр Сергеевич",
                  textType: TextType.header,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  title: "test@bk.ru",
                  textType: TextType.body,
                  color: ColorConstants.darkGrey,
                ),
                SizedBox(height: 30)
              ],
            )
          ],
        ),
      ),
    );
  }
}
