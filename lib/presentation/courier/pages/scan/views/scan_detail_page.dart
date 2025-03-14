import 'package:ase/data/bloc/search_box/search_box_cubit.dart';
import 'package:ase/data/bloc/take_order/take_order_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/request_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/views/order/widgets/handle_address_widget.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/card/order_card.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'ScanDetailRoute')
class ScanDetailPage extends StatefulWidget {
  const ScanDetailPage({super.key, required this.orderCode});
  final String orderCode;

  @override
  State<ScanDetailPage> createState() => _ScanDetailPageState();
}

class _ScanDetailPageState extends State<ScanDetailPage> {
  late final SearchBoxCubit _searchBoxCubit;

  @override
  void initState() {
    super.initState();
    _searchBoxCubit = SearchBoxCubit();
    _searchBoxCubit.searchOrder(widget.orderCode);
    CourierRepo().searchOrder(widget.orderCode);
  }

  final router = getIt<AppRouter>();
  @override
  void dispose() {
    _searchBoxCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBoxCubit,
      child: BlocBuilder<SearchBoxCubit, SearchBoxState>(
        builder: (context, state) {
          if (state is SearchBoxLoading) {
            return Scaffold(
              body: const Center(
                child: LoadingWidget(),
              ),
            );
          } else if (state is SearchBoxError) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                    DefElevatedButton(
                      text: LocaleKeys.button_cancel.tr(),
                      onPressed: () {
                        router.pop<bool>(true);
                      },
                      backgroundColor: ColorConstants.red,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is SearchBoxLoaded) {
            final box = state.box;
            return PopScope(
              canPop: false,
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      router.pop<bool>(true);
                    },
                    style: CustomBoxDecoration.backButtonStyle().copyWith(),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        flex: 1,
                        child: DefElevatedButton(
                          text: LocaleKeys.button_cancel.tr(),
                          onPressed: () => router.pop<bool>(true),
                          backgroundColor: ColorConstants.red,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BlocConsumer<TakeOrderCubit, TakeOrderState>(
                          listener: (context, state) {
                            if (state is TakeOrderError) {
                              showToast(state.message);
                            } else if (state is TakeOrderLoaded) {
                              router.pop<bool>(true);
                            }
                          },
                          builder: (context, state) {
                            if (state is TakeOrderLoading) {
                              return Center(child: const LoadingWidget());
                            }
                            return DefElevatedButton(
                                text: LocaleKeys.button_take.tr(),
                                onPressed: () {
                                  context
                                      .read<TakeOrderCubit>()
                                      .takeOrder(box.code ?? "");
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                body: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 20,
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: CustomBoxDecoration().copyWith(
                                color: ColorConstants.lightSlate,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          _infoCard(box),
                        ],
                      ))
                ]),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                "Barkod okutun...",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  void showToast(String message) {
    CherryToast.error(
      title: Text(LocaleKeys.exception_exception.tr()),
      description: Text(message),
      animationType: AnimationType.fromTop,
    ).show(context);
  }

  Column _infoCard(BoxModel box) {
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
        _buildOrderInfo(
            title: LocaleKeys.general_price.tr(), subtitle: box.price ?? ""),
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
