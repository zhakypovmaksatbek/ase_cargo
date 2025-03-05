// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/request_detail/request_detail_cubit.dart';
import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/utils/order_utils.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/card/request_card.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "RequestDetailRoute")
class RequestDetail extends StatefulWidget {
  const RequestDetail({
    super.key,
    required this.id,
  });
  final int id;
  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  late final RequestDetailCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = RequestDetailCubit()..getDetail(widget.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<RequestDetailCubit, RequestDetailState>(
        builder: (context, state) {
          if (state is RequestDetailLoading) {
            return Scaffold(
                body: Center(
              child: LoadingWidget(),
            ));
          } else if (state is RequestDetailError) {
            return Scaffold(
              body: Center(
                child: Text(state.error),
              ),
            );
          } else if (state is RequestDetailLoaded) {
            final RequestDetailModel detail = state.requestDetail;
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _buildFloatingActionButton(detail),
              body: CustomScrollView(
                slivers: [
                  DefSliverAppBar(
                      title: LocaleKeys.navigation_request_detail.tr()),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          _buildAddress(detail.address ?? Address()),
                          PreOrderStatusWidget(status: detail.status),
                          AppText(
                            title: LocaleKeys.general_delivery_info.tr(),
                            textType: TextType.body,
                            color: ColorConstants.lavenderBlue,
                          ),
                          ...detail.packages
                                  ?.map((e) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (e.name != null)
                                            AppText(
                                              title: e.name ?? "",
                                              textType: TextType.header,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          if (e.description != null)
                                            AppText(
                                              title: e.description ?? "",
                                              textType: TextType.body,
                                            ),
                                        ],
                                      ))
                                  .toList() ??
                              [],
                          _infoCard(detail),
                          Divider(color: ColorConstants.dividerColor),
                          if (detail.shipmentOptionPrice?.isNotEmpty ?? false)
                            _buildOrderInfo(
                                title: LocaleKeys.general_service_price.tr(),
                                subtitle: detail.shipmentOptionPrice ?? "0"),
                          if (detail.totalServicesPrice?.isNotEmpty ?? false)
                            _buildOrderInfo(
                                title: LocaleKeys
                                    .general_additional_service_price
                                    .tr(),
                                subtitle: detail.totalServicesPrice ?? "0"),
                          if (detail.price?.isNotEmpty ?? false)
                            _buildOrderInfo(
                                title: LocaleKeys.general_delivery_price.tr(),
                                subtitle: detail.price ?? "0"),
                          SizedBox(height: 160)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  Column _infoCard(RequestDetailModel detail) {
    return Column(
      spacing: 10,
      children: [
        _buildOrderInfo(
            title: LocaleKeys.general_weight.tr(),
            subtitle: "${detail.totalWeight ?? 0} kg"),
        _buildOrderInfo(
            title: LocaleKeys.general_delivery_type.tr(),
            subtitle: detail.shipmentOptionName ?? "-"),
        _buildOrderInfo(
            title: LocaleKeys.general_packages_type.tr(),
            subtitle: detail.packagesType ?? "-"),
        if (detail.additionServices?.isNotEmpty ?? false)
          _buildOrderInfo(
              title: LocaleKeys.general_additional_services.tr(),
              subtitle: detail.additionServices
                      ?.map((e) => e.name)
                      .where((e) => e != null)
                      .join(", ") ??
                  "-"),
        _buildOrderInfo(
            title: LocaleKeys.general_sender.tr(),
            subtitle: "${detail.sender?.name} (${detail.sender?.city})"),
        _buildOrderInfo(
            title: LocaleKeys.general_recipient.tr(),
            subtitle:
                "${detail.recipient?.name ?? ""} (${detail.recipient?.city ?? ""})"),
      ],
    );
  }

  Widget? _buildFloatingActionButton(RequestDetailModel detail) {
    final canPay = detail.userCanPay ?? false;
    final isAwaitingProcess = detail.status == "awaiting_process";
    final isWaitPayment = detail.status == "wait_payment";

    if (!canPay && !isAwaitingProcess && !isWaitPayment) {
      return null;
    }

    return BottomAppBar(
      color: Colors.transparent,
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (canPay)
            SizedBox(
              width: double.infinity,
              child: DefElevatedButton(
                text: LocaleKeys.general_pay.tr(),
              ),
            ),
          if (isAwaitingProcess || isWaitPayment)
            SizedBox(
              width: double.infinity,
              child: DefElevatedButton(
                text: LocaleKeys.button_cancel.tr(),
              ),
            ),
        ],
      ),
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

  Row _buildAddress(Address address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
                title: OrderUtils.formatAddress(address),
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
