// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/models/country_model.dart';
import 'package:ase/data/models/sender_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/drop_down/custom_drop_down.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/presentation/widgets/text_fields/phone_number_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondStepContent extends StatefulWidget {
  const SecondStepContent(
      {super.key,
      required this.sender,
      required this.senderError,
      required this.countries});
  final ValueNotifier<SenderModel> sender;
  final SenderErrorModel? senderError;
  final List<CountryModel> countries;
  @override
  State<SecondStepContent> createState() => _SecondStepContentState();
}

class _SecondStepContentState extends State<SecondStepContent> {
  final ValueNotifier<PersonType> selectedType =
      ValueNotifier<PersonType>(PersonType.physical);
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController inn = TextEditingController();
  final TextEditingController dateIssue = TextEditingController();
  final TextEditingController whoIssue = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController region = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final TextEditingController addressLine = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController innCompany = TextEditingController();
  @override
  void initState() {
    widget.sender.value =
        widget.sender.value.copyWith(entityType: PersonType.physical.key);

    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    phone.dispose();
    inn.dispose();
    dateIssue.dispose();
    whoIssue.dispose();
    city.dispose();
    region.dispose();
    zipcode.dispose();
    addressLine.dispose();

    super.dispose();
  }

  final FocusNode focus = FocusNode();
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
                        ? _physicalForm(context)
                        : _legalForm();
                  }),
              AppText(
                title: LocaleKeys.form_contact_data.tr(),
                textType: TextType.body,
                fontWeight: FontWeight.w500,
              ),
              PhoneNumberTextField(
                focusNode: focus,
                errorText: widget.senderError?.phone?.join(", "),
                onChanged: (p0) {
                  widget.sender.value = widget.sender.value.copyWith(phone: p0);
                },
              ),
              DefTextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: email,
                  errorText: widget.senderError?.email?.join(", "),
                  onChanged: (p0) {
                    widget.sender.value =
                        widget.sender.value.copyWith(email: email.text);
                  },
                  hintText: LocaleKeys.form_email.tr()),
              AppText(
                title: LocaleKeys.form_address.tr(),
                textType: TextType.body,
                fontWeight: FontWeight.w500,
              ),
              CustomDropDown<CountryModel>(
                validatorTitle: LocaleKeys.form_country.tr(),
                hint: LocaleKeys.form_choice_country.tr(),
                items: widget.countries,
                errorMessage: widget.senderError?.country?.join(", "),
                itemBuilder: (country) => country.name ?? "-",
                onChanged: (selectedCountry) {
                  widget.sender.value = widget.sender.value
                      .copyWith(country: selectedCountry?.code ?? "");
                },
              ),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: city,
                  errorText: widget.senderError?.city?.join(", "),
                  onChanged: (p0) {
                    widget.sender.value =
                        widget.sender.value.copyWith(city: city.text);
                  },
                  hintText: LocaleKeys.form_city.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  errorText: widget.senderError?.region?.join(", "),
                  controller: region,
                  onChanged: (p0) {
                    widget.sender.value =
                        widget.sender.value.copyWith(region: region.text);
                  },
                  hintText: LocaleKeys.form_region.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: addressLine,
                  errorText: widget.senderError?.addressLine?.join(", "),
                  onChanged: (p0) {
                    widget.sender.value = widget.sender.value
                        .copyWith(addressLine: addressLine.text);
                  },
                  hintText: LocaleKeys.form_address_apartment.tr()),
              DefTextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: zipcode,
                  errorText: widget.senderError?.zipcode?.join(", "),
                  onChanged: (p0) {
                    widget.sender.value =
                        widget.sender.value.copyWith(zipcode: zipcode.text);
                  },
                  hintText: LocaleKeys.form_index.tr()),
              CustomCheckBox(
                onChanged: (value) {
                  widget.sender.value =
                      widget.sender.value.copyWith(saveForm: value);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Column _physicalForm(BuildContext context) {
    ImagePickerCubit imageCubit = context.watch<ImagePickerCubit>();

    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: fullName,
            errorText: widget.senderError?.name?.join(", "),
            onChanged: (name) {
              widget.sender.value = widget.sender.value.copyWith(name: name);
            },
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
            controller: inn,
            errorText: widget.senderError?.tin?.join(", "),
            onChanged: (inn) {
              widget.sender.value = widget.sender.value.copyWith(tin: inn);
            },
            hintText: LocaleKeys.form_inn.tr()),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.now())
                      .then((value) {
                    final formattedDate = DateFormat('yyyy-MM-dd')
                        .format(value ?? DateTime.now());

                    dateIssue.text = formattedDate;
                    widget.sender.value =
                        widget.sender.value.copyWith(issueDate: formattedDate);
                  });
                },
                child: DefTextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    textInputAction: TextInputAction.next,
                    controller: dateIssue,
                    errorText: widget.senderError?.issueDate?.join(", "),
                    onChanged: (p0) {
                      widget.sender.value =
                          widget.sender.value.copyWith(issueDate: p0);
                    },
                    enabled: false,
                    hintText: LocaleKeys.form_date_issue.tr()),
              ),
            ),
            Expanded(
              child: DefTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  errorText: widget.senderError?.issuingAuthority?.join(", "),
                  onChanged: (date) {
                    widget.sender.value =
                        widget.sender.value.copyWith(issuingAuthority: date);
                  },
                  controller: whoIssue,
                  hintText: LocaleKeys.form_who_issue.tr()),
            ),
          ],
        ),
        AppText(
          title: LocaleKeys.form_upload_passport.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        UploadImageButton(
          onTap: () async {
            await imageCubit.pickImage(context, ImageType.frontFile).then(
              (value) {
                widget.sender.value =
                    widget.sender.value.copyWith(frontPartImg: value);
              },
            );
          },
          type: ImageType.frontFile,
          path: imageCubit.state.frontFile?.path,
          cubit: imageCubit,
        ),
        if (widget.senderError?.frontPartImg != null)
          AppText(
            title: widget.senderError?.frontPartImg?.join(", ") ?? "",
            textType: TextType.description,
            color: ColorConstants.red,
          ),
        AppText(
          title: LocaleKeys.form_upload_back_passport.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        UploadImageButton(
          onTap: () async {
            await imageCubit.pickImage(context, ImageType.backFile).then(
              (value) {
                widget.sender.value =
                    widget.sender.value.copyWith(backPartImg: value);
              },
            );
          },
          cubit: imageCubit,
          type: ImageType.backFile,
          path: imageCubit.state.backFile?.path,
        ),
        if (widget.senderError?.backPartImg != null)
          AppText(
            title: widget.senderError?.backPartImg?.join(", ") ?? "",
            textType: TextType.description,
            color: ColorConstants.red,
          )
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
            controller: companyName,
            errorText: widget.senderError?.name?.join(", "),
            onChanged: (name) {
              widget.sender.value = widget.sender.value.copyWith(name: name);
            },
            hintText: LocaleKeys.form_name_of_company.tr()),
        AppText(
          title: LocaleKeys.form_inn_company.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        DefTextField(
            controller: innCompany,
            onChanged: (inn) {
              widget.sender.value = widget.sender.value.copyWith(tin: inn);
            },
            errorText: widget.senderError?.tin?.join(", "),
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
        onTap: () {
          selectedType.value = type;
          widget.sender.value =
              widget.sender.value.copyWith(entityType: type.key);
        },
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

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<bool> onChanged;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSave = false;

  void onChanged(bool? value) {
    isSave = value ?? false;
    widget.onChanged(value ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isSave,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(LocaleKeys.form_save_data.tr()),
    );
  }
}

class UploadImageButton extends StatelessWidget {
  final void Function()? onTap;
  final String? path;
  final ImagePickerCubit cubit;
  final ImageType type;

  const UploadImageButton(
      {super.key,
      this.onTap,
      this.path,
      required this.cubit,
      required this.type});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: CustomBoxDecoration().copyWith(
          color: Colors.transparent,
          border: Border.all(width: 0.5, color: ColorConstants.grey),
        ),
        child: Row(
          spacing: 14,
          children: [
            path != null
                ? Image.file(
                    File(path!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Container(
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
              maxLines: 3,
            ),
            Spacer(),
            if (path?.isNotEmpty ?? false)
              IconButton.outlined(
                  padding: EdgeInsets.zero,
                  onPressed: () => cubit.removePickImage(type),
                  icon: Icon(Icons.close_outlined))
          ],
        ),
      ),
    );
  }
}
