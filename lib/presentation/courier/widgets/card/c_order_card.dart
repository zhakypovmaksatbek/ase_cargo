// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/take_order/take_order_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/courier/widgets/general/order_detail_content.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class COrderCard extends StatelessWidget {
  const COrderCard({
    super.key,
    required this.box,
    this.isCanceled = false,
  });

  final BoxModel box;
  final bool isCanceled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomSheet.showDefBottomSheet(
            context, COrderDetailContent(box: box, isCanceled: isCanceled));
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
            if (isCanceled) ReturnOrderButton(boxCode: box.code ?? "")
          ],
        ),
      ),
    );
  }
}

class ReturnOrderButton extends StatelessWidget {
  const ReturnOrderButton({
    super.key,
    required this.boxCode,
  });

  final String boxCode;
  static final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeOrderCubit, TakeOrderState>(
      builder: (context, state) {
        if (state is TakeOrderLoading && boxCode == state.boxCode) {
          return const Center(child: LoadingWidget());
        }
        return SizedBox(
          width: double.infinity,
          child: DefElevatedButton(
            text: LocaleKeys.button_return_from_canceled.tr(),
            onPressed: () {
              router.maybePop();
              context.read<TakeOrderCubit>().takeOrder(boxCode);
            },
          ),
        );
      },
    );
  }
}
