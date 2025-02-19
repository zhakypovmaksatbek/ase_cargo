import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/view/sender_form_view.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FirstStepContent extends StatelessWidget {
  FirstStepContent({super.key});

  final ValueNotifier<DeliveryType> selectedType =
      ValueNotifier<DeliveryType>(DeliveryType.delivery);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DeliveryType>(
        valueListenable: selectedType,
        builder: (context, value, _) {
          return Column(
            spacing: 20,
            children: [
              Container(
                decoration: CustomBoxDecoration().copyWith(
                  color: ColorConstants.lightGrey,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    _buildOption(
                      context,
                      type: DeliveryType.delivery,
                      isSelected: value == DeliveryType.delivery,
                    ),
                    _buildOption(
                      context,
                      type: DeliveryType.document,
                      isSelected: value == DeliveryType.document,
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Durations.extralong1,
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(bottom: 20),
                height: value == DeliveryType.delivery ? 700 : 140,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: CustomBoxDecoration(),
                child: value == DeliveryType.delivery
                    ? _buildDeliveryForm()
                    : _buildDocumentForm(),
              )
            ],
          );
        });
  }

  Column _buildDocumentForm() {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: LocaleKeys.form_enter_document_info.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            hintText: LocaleKeys.form_weight.tr()),
      ],
    );
  }

  SingleChildScrollView _buildDeliveryForm() {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: "Посылка № 1",
            textType: TextType.body,
            fontWeight: FontWeight.w600,
          ),
          AppText(
            title: LocaleKeys.general_delivery_info.tr(),
            textType: TextType.body,
            fontWeight: FontWeight.w500,
          ),
          DefTextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_name_field.tr()),
          DefTextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_description.tr()),
          DefTextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_weight.tr()),
          DefTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_price_product.tr()),
          SizedBox(),
          AppText(
            title: LocaleKeys.form_dimensions.tr(),
            textType: TextType.body,
            fontWeight: FontWeight.w500,
          ),
          DefTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_length.tr()),
          DefTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_width.tr()),
          DefTextField(
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
              textInputAction: TextInputAction.next,
              hintText: LocaleKeys.form_height.tr()),
          SizedBox(),
          Center(
              child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: ColorConstants.primary,
            child: Icon(Icons.add),
          )),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required DeliveryType type, required bool isSelected}) {
    return Expanded(
      child: InkWell(
        onTap: () => selectedType.value = type,
        borderRadius: BorderRadius.circular(14),
        splashColor: ColorConstants.white.withValues(alpha: .3),
        highlightColor: ColorConstants.white.withValues(alpha: .3),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: CustomBoxDecoration().copyWith(
            color:
                isSelected ? ColorConstants.primary : ColorConstants.lightGrey,
          ),
          child: AppText(
            title: type.title.tr(),
            textAlign: TextAlign.center,
            color: isSelected ? ColorConstants.white : ColorConstants.black,
            textType: TextType.body,
          ),
        ),
      ),
    );
  }
}
