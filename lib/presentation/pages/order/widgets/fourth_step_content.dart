import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FourthStepContent extends StatelessWidget {
  FourthStepContent({super.key, required this.onPayerChanged});
  final ValueChanged<Payer> onPayerChanged;
  final ValueNotifier<Payer> selectedPayer = ValueNotifier<Payer>(Payer.sender);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Payer>(
      valueListenable: selectedPayer,
      builder: (context, value, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: CustomBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              AppText(
                title: LocaleKeys.form_who_pay.tr(),
                textType: TextType.body,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(),
              ...Payer.values.map(
                (payer) => Container(
                  decoration: CustomBoxDecoration().copyWith(
                      color: value == payer ? ColorConstants.lightGrey : null),
                  child: RadioListTile<Payer>(
                    selectedTileColor: ColorConstants.blue,
                    title: Text(payer.title.tr()),
                    value: payer,
                    groupValue: value,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectedPayer.value = newValue;
                        onPayerChanged(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum Payer {
  sender(LocaleKeys.form_sender_pay),
  recipient(LocaleKeys.form_recipient_pay);

  const Payer(this.title);
  final String title;
}
