import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/card/order_card.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class COrderHistoryDetailContent extends StatelessWidget {
  const COrderHistoryDetailContent({
    super.key,
    required this.box,
  });

  final BoxModel box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: CustomBoxDecoration().copyWith(
                color: ColorConstants.lightSlate,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title: box.code ?? "",
                    textType: TextType.body,
                    fontWeight: FontWeight.w500,
                  ),
                  CopyButton(content: box.code ?? ""),
                ],
              )),
          HandleAddressWidget(
            address: Address(addressLine: box.address ?? ""),
          ),
          _infoCard(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Column _infoCard() {
    return Column(
      spacing: 10,
      children: [
        _buildOrderInfo(
            title: LocaleKeys.general_sender.tr(),
            subtitle: "${box.sender?.name} (${box.sender?.city})"),
        _buildOrderInfo(
            title: LocaleKeys.general_recipient.tr(),
            subtitle:
                "${box.recipient?.name ?? ""} (${box.recipient?.city ?? ""})"),
      ],
    );
  }

  Row _buildOrderInfo({required String title, required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: AppText(
            title: title,
            textType: TextType.body,
            color: ColorConstants.darkGrey,
          ),
        ),
        Flexible(
          flex: 1,
          child: AppText(
            title: subtitle,
            textType: TextType.body,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}
