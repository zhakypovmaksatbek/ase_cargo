import 'package:ase/data/bloc/register/register_cubit.dart';
import 'package:ase/data/models/register_model.dart';
import 'package:ase/data/models/verify_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/pages/auth/register/register_mixin.dart';
import 'package:ase/presentation/products/utils/validation.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:ase/presentation/widgets/text_fields/phone_number_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "RegisterRoute")
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final focusNode = FocusNode();
  final _validate = InputValidate.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final registerCubit = context.read<RegisterCubit>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: registerState,
      builder: (context, state) {
        RegisterErrorModel? error;
        if (state is RegisterError) {
          error = state.message;
        }
        return Scaffold(
          appBar: AppBar(),
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
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: CustomAssetImage(
                          path: AssetConstants.icon.png,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      AppText(
                          title: LocaleKeys.button_signup.tr(),
                          textType: TextType.header),
                      SizedBox(height: 0),

                      /// MARK: First Name
                      DefTextField(
                        hintText: "${LocaleKeys.form_first_name.tr()}*",
                        controller: firstNameController,
                        validator: _validate.validateGeneral,
                        errorText: error?.firstName?.firstOrNull,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          registerCubit.clearError("firstName");
                        },
                      ),

                      /// MARK: Last Name
                      DefTextField(
                        hintText: LocaleKeys.form_last_name.tr(),
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        errorText: error?.lastName?.firstOrNull,
                        onChanged: (value) {
                          registerCubit.clearError("lastName");
                        },
                      ),

                      /// MARK: Email
                      DefTextField(
                        hintText: "name@gmail.com",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        errorText: error?.email?.firstOrNull,
                        onChanged: (value) {
                          registerCubit.clearError("email");
                        },
                      ),

                      /// MARK: Phone
                      PhoneNumberTextField(
                          focusNode: focusNode,
                          errorText: error?.phone?.firstOrNull,
                          onChanged: (value) {
                            phone = value;

                            registerCubit.clearError("phone");
                          }),

                      /// MARK: Password
                      PasswordTextField(
                        hintText: "${LocaleKeys.form_password.tr()}*",
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        validator: _validate.validatePassword,
                        errorText: error?.password?.firstOrNull,
                        onChanged: (value) {
                          registerCubit.clearError("password");
                        },
                      ),
                      PasswordTextField(
                        hintText: "${LocaleKeys.form_confirm_password.tr()}*",
                        controller: confirmPasswordController,
                        validator: (value) => _validate.validateConfirmPassword(
                            value, passwordController.text),
                        onChanged: (value) {
                          registerCubit.clearError("password");
                        },
                      ),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return LoadingWidget();
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 6),
                            width: double.infinity,
                            child: ValueListenableBuilder(
                                valueListenable: ready,
                                builder: (context, value, child) {
                                  return DefElevatedButton(
                                    text: LocaleKeys.button_signup.tr(),
                                    onPressed: value ? onReady : null,
                                  );
                                }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void registerState(context, state) {
    if (state is RegisterSuccess) {
      router.push(VerifyRoute(
        model: VerifyModel(
            phone: phone,
            code: state.model.testCode,
            verifyToken: state.model.verifyToken),
        title: LocaleKeys.form_confirm_phone_number.tr(),
      ));
    } else if (state is RegisterError) {
      if (state.message.detail != null) {
        CherryToast.error(
          title: Text(LocaleKeys.exception_exception.tr()),
          description: Text(state.message.detail ?? ""),
          animationType: AnimationType.fromTop,
        ).show(context);
      }
    }
  }
}
