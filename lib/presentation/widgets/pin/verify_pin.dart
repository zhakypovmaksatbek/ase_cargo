// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class VerifyPin extends StatelessWidget {
  VerifyPin({
    super.key,
    required this.controller,
    this.validator,
    this.onCompleted,
    this.errorText,
    this.onChanged,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? errorText;

  final focusNode = FocusNode();
  PinTheme defaultPinTheme(BuildContext context) {
    return PinTheme(
      width: 72,
      height: 42,
      textStyle: TextStyle(
          fontSize: 22,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),

        // border: Border.all(color: ColorConstants.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        // Specify direction if desired
        textDirection: TextDirection.ltr,
        child: Center(
          child: Pinput(
            onChanged: onChanged,
            errorText: errorText,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            crossAxisAlignment: CrossAxisAlignment.center,
            controller: controller,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme(context),
            separatorBuilder: (index) => const SizedBox(width: 20),
            validator: validator,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: onCompleted,
            autofocus: true,
            toolbarEnabled: true,
            keyboardType: TextInputType.number,
            preFilledWidget: AppText(
              title: "x",
              textType: TextType.body,
              color: ColorConstants.grey,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            cursor: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 10,
                height: 1,
                color: ColorConstants.primary,
              ),
            ),
            pinAnimationType: PinAnimationType.fade,
            focusedPinTheme: defaultPinTheme(context).copyWith(
              decoration: defaultPinTheme(context).decoration!.copyWith(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.primary.withValues(alpha: .3),
                      spreadRadius: 3,
                      blurRadius: 0)
                ],
              ),
            ),
            submittedPinTheme: defaultPinTheme(context),
            errorPinTheme: defaultPinTheme(context).copyDecorationWith(
              border: Border.all(color: ColorConstants.red),
            ),
          ),
        ));
  }
}
