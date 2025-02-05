import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/pin/verify_pin.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'VerifyRoute')
class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key, required this.phone, this.code});
  final String phone;
  final String? code;

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          spacing: 6,
          children: [
            CustomAssetImage(
              path: AssetConstants.icon.png,
              width: 120,
              height: 120,
            ),
            SizedBox(height: size.height * 0.08),
            AppText(
              title: LocaleKeys.form_confirm_phone_number.tr(),
              textType: TextType.title,
            ),
            AppText(
              title: LocaleKeys.notification_we_sent_code_to_your_phone.tr(),
              textType: TextType.subtitle,
              color: theme.hintColor,
            ),
            SizedBox(
              height: 6,
            ),
            VerifyPin(controller: pinController),
          ],
        )),
      ),
    );
  }
}
