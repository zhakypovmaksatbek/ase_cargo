// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/pages/order/widgets/first_step_content.dart';
import 'package:ase/presentation/products/utils/validation.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.widget,
    required this.package,
    required this.value,
    required this.index,
    this.packageErrorInfoModel,
  });

  final FirstStepContent widget;
  final Packages package;
  final List<Packages> value;
  final int index;
  final PackagesError? packageErrorInfoModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppText(
                title: "Посылка № ${index + 1}",
                textType: TextType.body,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (value.length > 1)
              IconButton(
                onPressed: () {
                  final updatedList = widget.packagesList.value
                      .where((package) => package.id != value[index].id)
                      .toList();

                  widget.packagesList.value = updatedList;
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
        AppText(
          title: LocaleKeys.general_delivery_info.tr(),
          textType: TextType.body,
          fontWeight: FontWeight.w500,
        ),
        DefTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) {
              final updatedPackage = package.copyWith(name: newValue);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            hintText: LocaleKeys.form_name_field.tr()),
        DefTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) {
              final updatedPackage = package.copyWith(description: newValue);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            hintText: LocaleKeys.form_description.tr()),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            errorText: packageErrorInfoModel?.weight?.join(', '),
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            onChanged: (value) {
              final updatedPackage =
                  package.copyWith(weight: double.tryParse(value) ?? 0);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            hintText: LocaleKeys.form_weight.tr()),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            onChanged: (newValue) {
              final updatedPackage = package.copyWith(price: newValue);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
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
            errorText: packageErrorInfoModel?.length?.join(', '),
            onChanged: (value) {
              final updatedPackage =
                  package.copyWith(length: double.tryParse(value) ?? 0);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            hintText: LocaleKeys.form_length.tr()),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            errorText: packageErrorInfoModel?.width?.join(', '),
            onChanged: (value) {
              final updatedPackage =
                  package.copyWith(width: double.tryParse(value) ?? 0);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            hintText: LocaleKeys.form_width.tr()),
        DefTextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            errorText: packageErrorInfoModel?.height?.join(', '),
            onChanged: (value) {
              final updatedPackage =
                  package.copyWith(height: double.tryParse(value) ?? 0);
              widget.packagesList.value = List.from(widget.packagesList.value)
                ..[index] = updatedPackage;
            },
            hintText: LocaleKeys.form_height.tr()),
        SizedBox(height: 10),
      ],
    );
  }
}
