import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/phone_number_text_field.dart';
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'RestoreAccessRoute')
class RestoreAccessPage extends StatefulWidget {
  const RestoreAccessPage({super.key});

  @override
  State<RestoreAccessPage> createState() => _RestoreAccessPageState();
}

class _RestoreAccessPageState extends State<RestoreAccessPage> {
  final focusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String phone = "";
  final ValueNotifier<bool> ready = ValueNotifier(false);

  void validate() {
    if (_key.currentState!.validate()) {
      ready.value = true;
    } else {
      ready.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              onChanged: validate,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CustomAssetImage(
                      path: AssetConstants.icon.png,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 20),
                  AppText(
                      title: LocaleKeys.form_restore_access.tr(),
                      textType: TextType.title),
                  AppText(
                      title: LocaleKeys.form_enter_number_phone.tr(),
                      textType: TextType.body),
                  SizedBox(height: 10),
                  PhoneNumberTextField(
                      focusNode: focusNode,
                      onChanged: (value) {
                        phone = value;
                      }),
                  SizedBox(height: 10),
                  ValueListenableBuilder<bool>(
                      valueListenable: ready,
                      builder: (context, value, _) {
                        return SizedBox(
                            width: double.infinity,
                            child: DefElevatedButton(
                              text: LocaleKeys.button_get_code.tr(),
                              onPressed: value ? () {} : null,
                            ));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
