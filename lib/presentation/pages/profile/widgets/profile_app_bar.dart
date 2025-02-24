import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/widgets/user_profile_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserError) {
              return Center(
                  child: AppText(
                title: state.message,
                textType: TextType.body,
                color: ColorConstants.red,
              ));
            } else if (state is UserSuccess) {
              final user = state.user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  UserProfileImage(),
                  Column(
                    children: [
                      AppText(
                        title: "${user.firstName ?? ""} ${user.lastName ?? ""}",
                        textType: TextType.header,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        title: user.email ?? "",
                        textType: TextType.body,
                        color: ColorConstants.darkGrey,
                      ),
                      SizedBox(height: 30)
                    ],
                  )
                ],
              );
            } else {
              return Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }
}
