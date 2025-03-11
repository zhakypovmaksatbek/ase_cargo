// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/utils/order_utils.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HandleAddressWidget extends StatelessWidget {
  const HandleAddressWidget({
    super.key,
    this.address,
  });
  final Address? address;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        CustomAssetImage(
          path: AssetConstants.location.svg,
          isSvg: true,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: LocaleKeys.general_delivery_address.tr(),
                textType: TextType.subtitle,
                color: ColorConstants.lavenderBlue,
              ),
              AppText(
                title: OrderUtils.formatAddress(address ?? Address()),
                textType: TextType.body,
                color: ColorConstants.primary,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
