import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/widgets/general/order_detail_content.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class COrderCard extends StatelessWidget {
  const COrderCard({
    super.key,
    required this.box,
  });

  final BoxModel box;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBarModalBottomSheet(
            context: context,
            bounce: true,
            shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
            barrierColor: ColorConstants.black.withValues(alpha: .4),
            builder: (context) {
              return COrderDetailContent(box: box);
            });
      },
      child: Container(
        decoration: CustomBoxDecoration(),
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: CustomBoxDecoration().copyWith(
                  color: ColorConstants.lightSlate,
                ),
                child: AppText(
                  title: box.code ?? "",
                  textType: TextType.body,
                  fontWeight: FontWeight.w500,
                )),
            HandleAddressWidget(
              address: Address(
                addressLine: box.address ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
