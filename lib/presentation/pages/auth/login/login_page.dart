import 'package:ase/core/app_manager.dart';
import 'package:ase/data/bloc/login/login_cubit.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/auth/login/login_mixin.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:ase/presentation/widgets/text_fields/phone_number_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
// import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "LoginRoute")
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
      listener: listener,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                onChanged: validateForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 14,
                  children: [
                    Center(
                      child: CustomAssetImage(
                        path: AssetConstants.icon.png,
                        width: 120,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    AppText(
                        title: LocaleKeys.button_login.tr(),
                        textType: TextType.header),
                    SizedBox(height: 0),
                    PhoneNumberTextField(
                      focusNode: focusNode,
                      onChanged: (p0) {
                        phone = p0;
                      },
                    ),
                    PasswordTextField(
                      hintText: LocaleKeys.form_password.tr(),
                      controller: passwordController,
                      validator: validate.validatePassword,
                      onEditingComplete: () {
                        login(context);
                        focusNode.unfocus();
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => router.push(RestoreAccessRoute()),
                        child: AppText(
                          title: LocaleKeys.button_forgot_password.tr(),
                          textType: TextType.subtitle,
                          color: ColorConstants.grey,
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: ready,
                        builder: (context, value, child) {
                          return BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return LoadingWidget();
                              } else {
                                return SizedBox(
                                  width: double.infinity,
                                  child: DefElevatedButton(
                                    text: LocaleKeys.button_login.tr(),
                                    onPressed: value
                                        ? () {
                                            login(context);
                                          }
                                        : null,
                                  ),
                                );
                              }
                            },
                          );
                        }),
                    SizedBox(height: 0),
                    GestureDetector(
                      onTap: () => router.push(RegisterRoute()),
                      child: AppText(
                          title: LocaleKeys.form_no_account.tr(),
                          textType: TextType.body),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> listener(context, state) async {
    if (state is LoginError) {
      if (state.message.detail != null) {
        CherryToast.error(
          title: Text(LocaleKeys.exception_exception.tr()),
          description: Text(state.message.detail ?? ""),
          animationType: AnimationType.fromTop,
        ).show(context);
      }
    } else if (state is LoginSuccess) {
      final role = await AppManager.instance.getUserRole();
      if (role == "courier") {
        router.replaceAll([CourierMainRoute()]);
      } else {
        router.replaceAll([HomeRoute()]);
      }
    }
  }
}
