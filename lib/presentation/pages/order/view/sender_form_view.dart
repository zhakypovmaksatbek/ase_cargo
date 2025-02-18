import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SenderFormRoute')
class SenderFormView extends StatefulWidget {
  const SenderFormView({super.key});

  @override
  State<SenderFormView> createState() => _SenderFormViewState();
}

class _SenderFormViewState extends State<SenderFormView> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.navigation_fill_delivery_info.tr()),
        leading: BackButton(
          style: CustomBoxDecoration.backButtonStyle(),
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        elevation: 0,
        currentStep: currentStep,
        onStepContinue: () {
          setState(() {
            if (currentStep < (steps.length - 1)) {
              currentStep++;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            currentStep--;
          });
        },
        connectorColor: WidgetStatePropertyAll(ColorConstants.grey),
        controlsBuilder: (context, details) {
          return DefElevatedButton(
              onPressed: () {
                details.onStepContinue!();
              },
              text: LocaleKeys.button_next_step.tr());
        },
        steps: steps,
      ),
    );
  }

  List<Step> get steps {
    return [
      Step(
        title: AppText(title: "", textType: TextType.body),
        content: AppText(title: "1", textType: TextType.body),
        isActive: currentStep >= 0,
        state: currentStep <= 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: AppText(title: "", textType: TextType.body),
        content: AppText(title: "2", textType: TextType.body),
        isActive: currentStep >= 1,
        state: currentStep <= 1 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: AppText(title: "", textType: TextType.body),
        content: AppText(title: "3", textType: TextType.body),
        isActive: currentStep >= 2,
        state: currentStep <= 2 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: AppText(title: "", textType: TextType.body),
        content: AppText(title: "4", textType: TextType.body),
        isActive: currentStep >= 3,
        state: currentStep <= 3 ? StepState.editing : StepState.complete,
      ),
    ];
  }
}
