import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/pages/profile/views/user/user_info_mixin.dart';
import 'package:ase/presentation/pages/profile/views/user/widget/user_image_widget.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/error/custom_error_widget.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "UserInfoRoute")
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> with UserInfoMixin {
  final ValueNotifier<bool> _isChanged = ValueNotifier(false);

  void _setupListeners() {
    firstNameController.addListener(_onTextChanged);
    lastNameController.addListener(_onTextChanged);
    emailController.addListener(_onTextChanged);
    phoneNumberController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _isChanged.value = _checkIfChanged();
  }

  bool _checkIfChanged() {
    final state = context.read<UserCubit>().state;
    if (state is UserSuccess) {
      return firstNameController.text != (state.user.fullName ?? "") ||
          lastNameController.text != (state.user.fullName ?? "") ||
          emailController.text != (state.user.email ?? "");
    }
    return false;
  }

  @override
  void dispose() {
    firstNameController.removeListener(_onTextChanged);
    lastNameController.removeListener(_onTextChanged);
    emailController.removeListener(_onTextChanged);
    phoneNumberController.removeListener(_onTextChanged);

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initData(context);
    _setupListeners();
  }

  void initData(BuildContext context) {
    context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    ImagePickerCubit formCubit = context.watch<ImagePickerCubit>();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ValueListenableBuilder<bool>(
            valueListenable: _isChanged,
            builder: (context, value, _) {
              return DefElevatedButton(
                text: LocaleKeys.button_save.tr(),
                onPressed: value ? () {} : null,
              );
            }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          initData(context);
        },
        child: CustomScrollView(
          slivers: <Widget>[
            DefSliverAppBar(title: LocaleKeys.navigation_userInfo.tr()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: BlocConsumer<UserCubit, UserState>(
                  listener: _userCubitState,
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      return Column(
                        spacing: 20,
                        children: [
                          UserImageWidget(
                              imageUrl: "https://picsum.photos/200/300",
                              formCubit: formCubit),
                          DefTextField(
                            hintText: "${LocaleKeys.form_first_name.tr()}*",
                            controller: firstNameController,
                            validator: validate.validateGeneral,
                            // errorText: error?.firstName?.firstOrNull,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              // context.read<RegisterCubit>().clearError("firstName");
                            },
                          ),
                          DefTextField(
                            hintText: "${LocaleKeys.form_last_name.tr()}*",
                            controller: lastNameController,
                            validator: validate.validateGeneral,
                            // errorText: error?.lastName?.firstOrNull,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              // context.read<RegisterCubit>().clearError("lastName");
                            },
                          ),
                          DefTextField(
                            hintText: "${LocaleKeys.form_email.tr()}*",
                            controller: emailController,
                            validator: validate.validateEmail,
                            // errorText: error?.email?.firstOrNull,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                          ),
                          DefTextField(
                            hintText: "${LocaleKeys.form_phone_number.tr()}*",
                            enabled: false,
                            validator: validate.validateGeneral,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            controller: phoneNumberController,
                          ),
                        ],
                      );
                    } else if (state is UserError) {
                      return CustomErrorWidget(message: state.message);
                    } else {
                      return Center(
                        child: LoadingWidget(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _userCubitState(context, state) {
    if (!mounted) return;
    if (state is UserSuccess) {
      firstNameController.text = state.user.fullName ?? "";
      lastNameController.text = state.user.fullName ?? "";
      emailController.text = state.user.email ?? "";
      phoneNumberController.text = state.user.phone ?? "";
    }
  }
}
