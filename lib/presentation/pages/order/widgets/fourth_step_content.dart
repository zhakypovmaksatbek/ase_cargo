// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/shipment_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FourthStepContent extends StatelessWidget {
  final ValueChanged<Payer> onPayerChanged;
  final ShipmentOption currentShipment;
  final ValueChanged<ShipmentModel> onDeliveryChanged;
  final ValueNotifier<Payer> selectedPayer = ValueNotifier<Payer>(Payer.sender);
  final List<ShipmentModel>? shipmentOptions;
  final ValueNotifier<ShipmentModel?> selectedDeliveryType;

  FourthStepContent(
      {super.key,
      required this.onPayerChanged,
      required this.onDeliveryChanged,
      this.shipmentOptions,
      required this.selectedDeliveryType,
      required this.currentShipment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: CustomBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              ValueListenableBuilder<Payer>(
                  valueListenable: selectedPayer,
                  builder: (context, value, _) {
                    return Column(
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
                                color: value == payer
                                    ? ColorConstants.lightGrey
                                    : null),
                            child: RadioListTile<Payer>(
                              selectedTileColor: ColorConstants.blue,
                              title: Text(payer.title.tr(namedArgs: {
                                "who": payer.name == currentShipment.name
                                    ? LocaleKeys.form_me.tr()
                                    : ""
                              })),
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
                        SizedBox(),
                      ],
                    );
                  }),
              if ((shipmentOptions?.isNotEmpty ?? false) &&
                  (shipmentOptions?.length ?? 0) > 1)
                ValueListenableBuilder<ShipmentModel?>(
                    valueListenable: selectedDeliveryType,
                    builder: (context, value, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          AppText(
                            title: LocaleKeys.form_select_delivery_type.tr(),
                            textType: TextType.body,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(),
                          ...shipmentOptions?.map(
                                (option) => Container(
                                  decoration: CustomBoxDecoration().copyWith(
                                      color: value == option
                                          ? ColorConstants.lightGrey
                                          : null),
                                  child: RadioListTile<ShipmentModel>(
                                    selectedTileColor: ColorConstants.blue,
                                    title: Text(option.name ?? ""),
                                    value: option,
                                    secondary: option.price == "0.00"
                                        ? null
                                        : AppText(
                                            title: option.price ?? "",
                                            textType: TextType.body,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    groupValue: value,
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        selectedDeliveryType.value = newValue;
                                        onDeliveryChanged(newValue);
                                      }
                                    },
                                  ),
                                ),
                              ) ??
                              [],
                        ],
                      );
                    }),
            ],
          ),
        ),
        SizedBox(
          height: 400,
        )
      ],
    );
  }
}
