import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SecondStepContent extends StatelessWidget {
  SecondStepContent({super.key});

  final ValueNotifier<PersonType> selectedType =
      ValueNotifier<PersonType>(PersonType.physical);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        ValueListenableBuilder<PersonType>(
          valueListenable: selectedType,
          builder: (context, value, _) {
            return Container(
              decoration: CustomBoxDecoration().copyWith(
                color: ColorConstants.lightGrey,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  _buildOption(
                    context,
                    type: PersonType.physical,
                    isSelected: value == PersonType.physical,
                  ),
                  _buildOption(
                    context,
                    type: PersonType.legal,
                    isSelected: value == PersonType.legal,
                  ),
                ],
              ),
            );
          },
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: CustomBoxDecoration(),
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              ValueListenableBuilder<PersonType>(
                  valueListenable: selectedType,
                  builder: (context, value, _) {
                    return value == PersonType.physical
                        ? _physicalForm()
                        : _legalForm();
                  }),
              AppText(
                title: LocaleKeys.form_contact_data.tr(),
                textType: TextType.body,
                fontWeight: FontWeight.w500,
              ),
              DefTextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_phone_number.tr()),
              DefTextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_email.tr()),
              AppText(
                title: LocaleKeys.form_address.tr(),
                textType: TextType.body,
                fontWeight: FontWeight.w500,
              ),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_country.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_city.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_region.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_address_apartment.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_index.tr()),
            ],
          ),
        ),
      ],
    );
  }

  Column _physicalForm() {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hintText: LocaleKeys.form_full_name.tr()),
        AppText(
          title: LocaleKeys.form_passport_data.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            hintText: LocaleKeys.form_inn.tr()),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: DefTextField(
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_date_issue.tr()),
            ),
            Expanded(
              child: DefTextField(
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  textInputAction: TextInputAction.next,
                  hintText: LocaleKeys.form_who_issue.tr()),
            ),
          ],
        ),
        AppText(
          title: LocaleKeys.form_upload_passport.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        UploadImageButton(),
        AppText(
          title: LocaleKeys.form_upload_back_passport.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        UploadImageButton(),
      ],
    );
  }

  Column _legalForm() {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hintText: LocaleKeys.form_name_of_company.tr()),
        AppText(
          title: LocaleKeys.form_inn_company.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            hintText: LocaleKeys.form_inn.tr()),
      ],
    );
  }

  Widget _buildOption(BuildContext context,
      {required PersonType type, required bool isSelected}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => selectedType.value = type,
        child: Container(
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

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: CustomBoxDecoration().copyWith(
          color: Colors.transparent,
          border: Border.all(width: 0.5, color: ColorConstants.grey),
        ),
        child: Row(
          spacing: 14,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: CustomBoxDecoration.circleDecoration().copyWith(
                  color: ColorConstants.lightGrey,
                  border: Border.all(
                      width: 8, color: ColorConstants.backgroundLight)),
              child: CustomAssetImage(
                path: AssetConstants.gallery.svg,
                isSvg: true,
              ),
            ),
            AppText(
              title: LocaleKeys.form_upload_photo.tr(),
              textType: TextType.body,
              fontWeight: FontWeight.bold,
              color: ColorConstants.darkBlue,
            )
          ],
        ),
      ),
    );
  }
}

enum PersonType {
  physical(title: LocaleKeys.form_physical),
  legal(title: LocaleKeys.form_legal);

  final String title;

  const PersonType({required this.title});
}
