import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/auth/login/login_mixin.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage(name: "LoginRoute")
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  _buildTextField(
                    CountryCodePicker(
                      initialSelection: 'kg',
                      showFlag: false,
                      showFlagDialog: true,
                      onChanged: (value) {},
                    ),
                  ),
                  PasswordTextField(
                    hintText: LocaleKeys.form_password.tr(),
                    controller: passwordController,
                    validator: validate.validatePassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppText(
                      title: LocaleKeys.button_forgot_password.tr(),
                      textType: TextType.subtitle,
                      color: ColorConstants.grey,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable: ready,
                        builder: (context, value, child) {
                          return DefElevatedButton(
                            text: LocaleKeys.button_login.tr(),
                            onPressed: value ? () {} : null,
                          );
                        }),
                  ),
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
    );
  }

  Widget _buildTextField(Widget prefixIcon) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      controller: phoneController,
      validator: validate.validateGeneral,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneNumberFormatter(),
      ],
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: '(xxx) xxx-xxx',
      ),
    );
  }
}
