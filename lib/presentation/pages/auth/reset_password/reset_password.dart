import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/utils/validation.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'ResetPasswordRoute')
class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final InputValidate validate = InputValidate.instance;

  final ValueNotifier<bool> isReady = ValueNotifier(false);

  void validateForm() {
    if (formKey.currentState!.validate()) {
      isReady.value = true;
    } else {
      isReady.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.navigation_reset_password.tr()),
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              onChanged: validateForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 14,
                children: [
                  AppText(
                      title: LocaleKeys.navigation_reset_password.tr(),
                      textType: TextType.header),
                  AppText(
                      title: LocaleKeys.general_create_new_password.tr(),
                      textType: TextType.subtitle),
                  SizedBox(height: 16),
                  PasswordTextField(
                    hintText: "${LocaleKeys.form_old_password.tr()}*",
                    controller: oldPasswordController,
                    validator: validate.validatePassword,
                  ),
                  PasswordTextField(
                    hintText: "${LocaleKeys.form_new_password.tr()}*",
                    controller: passwordController,
                    validator: validate.validatePassword,
                  ),
                  PasswordTextField(
                    hintText: "${LocaleKeys.form_confirm_password.tr()}*",
                    controller: confirmPasswordController,
                    validator: (value) {
                      return validate.validateConfirmPassword(
                          value, passwordController.text);
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable: isReady,
                        builder: (context, value, child) {
                          return DefElevatedButton(
                            text: LocaleKeys.button_apply.tr(),
                            onPressed: value ? () {} : null,
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
