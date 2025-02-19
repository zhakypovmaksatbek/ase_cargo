import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/widgets/first_step_content.dart';
import 'package:ase/presentation/pages/order/widgets/fourth_step_content.dart';
import 'package:ase/presentation/pages/order/widgets/second_step_content.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SenderFormRoute')
class SenderFormView extends StatefulWidget {
  const SenderFormView({super.key});

  @override
  State<SenderFormView> createState() => _SenderFormViewState();
}

class _SenderFormViewState extends State<SenderFormView> {
  final ValueNotifier<int> _currentStep = ValueNotifier<int>(0);
  String title(int currentStep) {
    switch (currentStep) {
      case 0:
        return LocaleKeys.navigation_fill_delivery_info.tr();
      case 1:
        return LocaleKeys.navigation_fill_sender_info.tr();
      case 2:
        return LocaleKeys.navigation_fill_recipient_info.tr();
      case 3:
        return LocaleKeys.navigation_additional.tr();
      default:
        return LocaleKeys.navigation_fill_delivery_info.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentStep,
      builder: (context, step, _) {
        return Scaffold(
            appBar: AppBar(
              title: AppText(
                title: title(step),
                textType: TextType.header,
              ),
              leading: BackButton(
                style: CustomBoxDecoration.backButtonStyle(),
              ),
            ),
            bottomSheet: step == 3
                ? Container(
                    decoration: CustomBoxDecoration(),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title: LocaleKeys.form_write_comment.tr(),
                          textType: TextType.body,
                        ),
                        DefTextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            maxLines: 3,
                            hintText: LocaleKeys.form_comments.tr()),
                        SizedBox(),
                        SizedBox(
                            width: double.infinity,
                            child: DefElevatedButton(
                              text: LocaleKeys.button_apply.tr(),
                              onPressed: () {},
                            ))
                      ],
                    ),
                  )
                : null,
            body: Stepper(
              elevation: 0,
              type: StepperType.horizontal,
              currentStep: step,
              controlsBuilder: (context, details) {
                if (details.currentStep != 3) {
                  return DefElevatedButton(
                      text: LocaleKeys.button_next_step.tr(),
                      onPressed: details.onStepContinue);
                } else {
                  return SizedBox();
                }
              },
              stepIconBuilder: (stepIndex, stepState) {
                return AppText(
                  title: (1 + stepIndex).toString(),
                  textType: TextType.body,
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w600,
                );
              },
              onStepContinue: () {
                if (step < 3) {
                  _currentStep.value++;
                }
              },
              onStepTapped: (value) {
                _currentStep.value = value;
              },
              onStepCancel: () {
                if (step > 0) {
                  _currentStep.value--;
                }
              },
              steps: [
                _buildStep(content: FirstStepContent(), isActive: step >= 0),
                _buildStep(content: SecondStepContent(), isActive: step >= 1),
                _buildStep(content: SecondStepContent(), isActive: step >= 2),
                _buildStep(
                    content: FourthStepContent(
                      onPayerChanged: (value) {
                        if (kDebugMode) {
                          print(value.title.tr());
                        }
                      },
                    ),
                    isActive: step >= 3),
              ],
            ));
      },
    );
  }

  Step _buildStep({required Widget content, required bool isActive}) {
    return Step(
      title: SizedBox(),
      content: content,
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.indexed,
    );
  }
}

enum DeliveryType {
  delivery(LocaleKeys.general_delivery),
  document(LocaleKeys.general_document);

  const DeliveryType(this.title);
  final String title;
}
