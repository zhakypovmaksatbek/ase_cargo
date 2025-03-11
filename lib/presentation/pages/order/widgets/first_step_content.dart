// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/products/utils/validation.dart';
import 'package:ase/presentation/widgets/card/package_card.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FirstStepContent extends StatefulWidget {
  const FirstStepContent({
    super.key,
    required this.onPayerChanged,
    required this.weigh,
    required this.packagesList,
    this.packageErrorInfoModel,
  });
  final ValueChanged<DeliveryType> onPayerChanged;
  final ValueChanged<double> weigh;

  final ValueNotifier<List<Packages>> packagesList;
  final PackageErrorInfoModel? packageErrorInfoModel;
  @override
  State<FirstStepContent> createState() => _FirstStepContentState();
}

class _FirstStepContentState extends State<FirstStepContent> {
  final ValueNotifier<DeliveryType> selectedType =
      ValueNotifier<DeliveryType>(DeliveryType.parcel);

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
                      type: DeliveryType.parcel,
                      isSelected: value == DeliveryType.parcel,
                    ),
                    _buildOption(
                      context,
                      type: DeliveryType.docs,
                      isSelected: value == DeliveryType.docs,
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Durations.extralong1,
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: CustomBoxDecoration(),
                child: value == DeliveryType.parcel
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
            inputFormatters: InputValidate.instance.inputDoubleFormatters,
            errorText: widget.packageErrorInfoModel?.packages?["0"]?.weight
                ?.join(", "),
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            textInputAction: TextInputAction.next,
            onChanged: (p0) {
              widget.weigh(double.tryParse(p0) ?? 0);
            },
            hintText: LocaleKeys.form_weight.tr()),
      ],
    );
  }

  Widget _buildDeliveryForm() {
    return ValueListenableBuilder(
        valueListenable: widget.packagesList,
        builder: (context, value, _) {
          return Column(
            children: [
              ListView.builder(
                itemCount: value.length,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final package = value[index];

                  return PackageCard(
                    widget: widget,
                    package: package,
                    index: index,
                    value: widget.packagesList.value,
                    packageErrorInfoModel: widget
                        .packageErrorInfoModel?.packages?[index.toString()],
                  );
                },
              ),
              Center(
                  child: IconButton.filled(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14))),
                ),
                onPressed: () {
                  widget.packagesList.value = List.from(value)..add(Packages());
                },
                icon: Icon(Icons.add),
              )),
            ],
          );
        });
  }

  Widget _buildOption(BuildContext context,
      {required DeliveryType type, required bool isSelected}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.onPayerChanged(type);
          selectedType.value = type;
        },
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
