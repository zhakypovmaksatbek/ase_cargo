import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/pages/auth/register/register_mixin.dart';
import 'package:ase/presentation/utils/validation.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage(name: "RegisterRoute")
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final _validate = InputValidate.instance;
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
                  DefTextField(
                    hintText: "${LocaleKeys.form_first_name.tr()}*",
                    controller: firstNameController,
                    validator: _validate.validateGeneral,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  DefTextField(
                    hintText: LocaleKeys.form_last_name.tr(),
                    controller: lastNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  DefTextField(
                    hintText: "name@gmail.com",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  _buildTextField(
                    CountryCodePicker(
                      initialSelection: 'kg',
                      showFlag: false,
                      showFlagDialog: true,
                      onChanged: (value) {
                        countryCode = value.dialCode;
                      },
                    ),
                  ),
                  PasswordTextField(
                    hintText: "${LocaleKeys.form_password.tr()}*",
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    validator: _validate.validatePassword,
                  ),
                  PasswordTextField(
                    hintText: "${LocaleKeys.form_confirm_password.tr()}*",
                    controller: confirmPasswordController,
                    validator: (value) => _validate.validateConfirmPassword(
                        value, passwordController.text),
                  ),
                  Container(
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
                  ),
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
      validator: (value) => _validate.validateGeneral(value),
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
