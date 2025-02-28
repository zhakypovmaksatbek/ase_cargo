// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/bloc/country/country_cubit.dart';
import 'package:ase/data/bloc/form/form_cubit.dart';
import 'package:ase/data/bloc/form_detail/form_detail_cubit.dart';
import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/shipment/shipment_cubit.dart';
import 'package:ase/data/models/form_detail_model.dart';
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/order/view/sender_form_mixin.dart';
import 'package:ase/presentation/pages/order/widgets/first_step_content.dart';
import 'package:ase/presentation/pages/order/widgets/fourth_step_content.dart';
import 'package:ase/presentation/pages/order/widgets/second_step_content.dart';
import 'package:ase/presentation/pages/order/widgets/thirth_step_content.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:ase/presentation/widgets/error/custom_error_widget.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage(name: 'SenderFormRoute')
class SenderFormView extends StatefulWidget {
  const SenderFormView({super.key, required this.userRole});
  final ShipmentOption userRole;
  @override
  State<SenderFormView> createState() => _SenderFormViewState();
}

class _SenderFormViewState extends State<SenderFormView> with SenderFormMixin {
  late final CountryCubit _countryCubit;
  @override
  void initState() {
    super.initState();
    _countryCubit = CountryCubit(FormRepo())..getCountries();
    context.read<ShipmentCubit>().getShipmentOptions(widget.userRole);
    packagesList.value.add(Packages());

    addition.value = addition.value.copyWith(
      personalPayment: true,
    );
  }

  @override
  void dispose() {
    _countryCubit.close();
    addition.dispose();
    packagesList.dispose();
    additionError.dispose();
    selectedDeliveryType.dispose();
    sender.dispose();
    senderError.dispose();
    currentStep.dispose();
    shipmentOptions.dispose();
    recipient.dispose();
    recipientError.dispose();
    packageErrorInfoModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _countryCubit,
      child: BlocListener<CountryCubit, CountryState>(
        listener: (context, state) {
          if (state is CountrySuccess) {
            countries = state.countries;
          }
        },
        child: BlocListener<ShipmentCubit, ShipmentState>(
          listener: (context, state) {
            if (state is ShipmentOptionsLoaded) {
              shipmentOptions.value = state.options;
              selectedDeliveryType.value = state.options.firstOrNull;
              addition.value = addition.value.copyWith(
                shipmentOption: state.options.firstOrNull?.id,
              );
            }
          },
          child: ValueListenableBuilder<int>(
            valueListenable: currentStep,
            builder: (context, step, _) {
              return BlocListener<FormCubit, FormCubitState>(
                listener: (context, state) async {
                  if (state is FormSuccess) {
                    context.read<FormCubit>().clearErrorMessages();
                    cleanErrorMessages();
                    if (step < 3) {
                      currentStep.value++;
                    } else if (state.steps == FormSteps.fifth) {
                      context.read<FormDetailCubit>().getFormDetail();
                      showFormDetailBottomSheet(context);
                    } else if (state.steps == FormSteps.finish) {
                      context.read<ImagePickerCubit>().cleanData();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: AppText(
                                    title: LocaleKeys
                                        .notification_order_is_being_reviewed
                                        .tr(),
                                    textType: TextType.body),
                                content: AppText(
                                    title: LocaleKeys.notification_please_wait
                                        .tr(),
                                    textType: TextType.body),
                              ));
                      await Future.delayed(Duration(seconds: 2), () {
                        if (context.mounted) {
                          router.maybePop();
                          router.replaceAll([MainRoute()]);
                        }
                      });
                    }
                  } else if (state is FormError) {
                    if (state.packageErrorInfoModel != null) {
                      packageErrorInfoModel.value = state.packageErrorInfoModel;
                    } else if (state.senderErrorModel != null) {
                      senderError.value = state.senderErrorModel;
                    } else if (state.recipientErrorModel != null) {
                      recipientError.value = state.recipientErrorModel;
                    } else if (state.errorDetail != null) {
                      CherryToast.error(
                        title: Text(LocaleKeys.exception_exception.tr()),
                        description: Text(state.errorDetail ??
                            LocaleKeys.exception_something_went_wrong_try_again
                                .tr()),
                        animationType: AnimationType.fromTop,
                      ).show(context);
                    }
                  }
                },
                child: PopScope(
                  canPop: false,
                  child: Scaffold(
                      appBar: AppBar(
                        title: AppText(
                          title: title(step),
                          textType: TextType.header,
                        ),
                        leading: BackButton(
                          style: CustomBoxDecoration.backButtonStyle(),
                          onPressed: () async {
                            final bool? isConfirm =
                                await AppDialogs.warningDialog(
                              context,
                              message: LocaleKeys.notification_want_to_exit_page
                                  .tr(),
                              confirmTitle: LocaleKeys.button_close.tr(),
                            );
                            if (isConfirm ?? false) {
                              router.back();
                            }
                          },
                        ),
                      ),
                      bottomSheet: step == 3
                          ? Container(
                              decoration: CustomBoxDecoration(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    title: LocaleKeys.form_write_comment.tr(),
                                    textType: TextType.body,
                                  ),
                                  DefTextField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onChanged: (p0) {
                                        addition.value = addition.value
                                            .copyWith(comment: p0);
                                      },
                                      maxLines: 3,
                                      hintText: LocaleKeys.form_comments.tr()),
                                  SizedBox(),
                                  BlocBuilder<FormCubit, FormCubitState>(
                                    builder: (context, state) {
                                      if (state is FormLoading) {
                                        return const Center(
                                          child: LoadingWidget(),
                                        );
                                      }
                                      return SizedBox(
                                          width: double.infinity,
                                          child: DefElevatedButton(
                                            text: LocaleKeys.button_apply.tr(),
                                            onPressed: () {
                                              sendAdditionInfo(context);
                                            },
                                          ));
                                    },
                                  )
                                ],
                              ),
                            )
                          : null,
                      body: Stepper(
                        elevation: 0,
                        type: StepperType.horizontal,
                        currentStep: step,
                        controlsBuilder: (context, details) {
                          if (details.currentStep != 3) {
                            return BlocBuilder<FormCubit, FormCubitState>(
                              builder: (context, state) {
                                if (state is FormLoading) {
                                  return Center(
                                    child: LoadingWidget(),
                                  );
                                }
                                return DefElevatedButton(
                                    text: LocaleKeys.button_next_step.tr(),
                                    onPressed: details.onStepContinue);
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                        stepIconBuilder: (stepIndex, stepState) {
                          return AppText(
                            title: (1 + stepIndex).toString(),
                            textType: TextType.body,
                            color: ColorConstants.white,
                            fontWeight: FontWeight.w600,
                          );
                        },
                        onStepContinue: () {
                          onContinue(context);
                        },
                        onStepTapped: (value) {
                          // currentStep.value = value;
                        },
                        onStepCancel: () {
                          if (step > 0) {
                            currentStep.value--;
                          }
                        },
                        steps: [
                          _buildStep(
                              content: ValueListenableBuilder(
                                  valueListenable: packageErrorInfoModel,
                                  builder: (context, error, _) {
                                    return FirstStepContent(
                                      packageErrorInfoModel: error,
                                      packagesList: packagesList,
                                      onPayerChanged: (value) {
                                        deliveryType = value;
                                      },
                                      weigh: (value) {
                                        weight = value;
                                      },
                                    );
                                  }),
                              isActive: step >= 0),
                          _buildStep(
                              content: ValueListenableBuilder(
                                  valueListenable: senderError,
                                  builder: (context, error, _) {
                                    return SecondStepContent(
                                      sender: sender,
                                      countries: countries,
                                      senderError: error,
                                    );
                                  }),
                              isActive: step >= 1),
                          _buildStep(
                              content: ValueListenableBuilder(
                                  valueListenable: recipientError,
                                  builder: (context, error, _) {
                                    return ThirdStepContent(
                                      recipient: recipient,
                                      recipientError: error,
                                      countries: countries,
                                    );
                                  }),
                              isActive: step >= 2),
                          _buildStep(
                              content: ValueListenableBuilder(
                                  valueListenable: shipmentOptions,
                                  builder: (context, options, _) {
                                    return FourthStepContent(
                                      currentShipment: widget.userRole,
                                      selectedDeliveryType:
                                          selectedDeliveryType,
                                      shipmentOptions: options,
                                      onPayerChanged: (value) {
                                        addition.value =
                                            addition.value.copyWith(
                                          personalPayment:
                                              value == Payer.sender,
                                        );
                                      },
                                      onDeliveryChanged: (value) {
                                        addition.value =
                                            addition.value.copyWith(
                                          shipmentOption: value.id,
                                        );
                                      },
                                    );
                                  }),
                              isActive: step >= 3),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> showFormDetailBottomSheet(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      bounce: true,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14)),
      barrierColor: ColorConstants.black.withValues(alpha: .4),
      builder: (context) {
        return BlocBuilder<FormDetailCubit, FormDetailState>(
          builder: (context, state) {
            if (state is FormDetailSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      AppText(
                          title: LocaleKeys.form_check_correct.tr(),
                          textType: TextType.header),
                      ...state.formDetail.packagesStep?.packages
                              ?.map((e) => PackageDetailCard(
                                    detail: state.formDetail,
                                    packagesDetail: e,
                                  ))
                              .toList() ??
                          [
                            AppText(
                                title: LocaleKeys
                                    .notification_not_found_package_info
                                    .tr(),
                                textType: TextType.body),
                            SizedBox(height: 60)
                          ],
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                            onPressed: () {
                              router.maybePop().then(
                                (value) {
                                  currentStep.value = 0;
                                },
                              );
                            },
                            iconAlignment: IconAlignment.end,
                            icon: CustomAssetImage(
                              path: AssetConstants.edit.svg,
                              isSvg: true,
                            ),
                            label: Text(LocaleKeys.button_edit.tr())),
                      ),
                      BlocBuilder<FormCubit, FormCubitState>(
                        builder: (context, state) {
                          if (state is FormLoading) {
                            return Center(child: const LoadingWidget());
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: DefElevatedButton(
                                text: LocaleKeys.button_confirm.tr(),
                                onPressed: () =>
                                    context.read<FormCubit>().saveForm()),
                          );
                        },
                      ),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              );
            } else if (state is FormDetailError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomErrorWidget(
                      message: LocaleKeys
                          .exception_something_went_wrong_try_again
                          .tr()),
                  IconButton.filled(
                      onPressed: () =>
                          context.read<FormDetailCubit>().getFormDetail(),
                      icon: Icon(Icons.refresh_rounded)),
                  SizedBox(height: 60)
                ],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: LoadingWidget(),
                  ),
                  SizedBox(height: 60)
                ],
              );
            }
          },
        );
      },
    );
  }

  Step _buildStep({required Widget content, required bool isActive}) {
    return Step(
      title: SizedBox(),
      content: content,
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.indexed,
    );
  }
}

class PackageDetailCard extends StatelessWidget {
  const PackageDetailCard({
    super.key,
    required this.detail,
    required this.packagesDetail,
  });
  final FormDetailModel detail;
  final PackagesDetail packagesDetail;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          CustomBoxDecoration().copyWith(color: ColorConstants.backgroundLight),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          AppText(
              title: LocaleKeys.general_delivery.tr(namedArgs: {"number": "1"}),
              textType: TextType.header),
          if (packagesDetail.name != null)
            AppText(
              title: packagesDetail.name ?? "",
              textType: TextType.header,
              fontWeight: FontWeight.w500,
            ),
          if (packagesDetail.description != null)
            AppText(
                title: packagesDetail.description ?? "",
                textType: TextType.body),
          _buildInfo(LocaleKeys.form_weight.tr(), packagesDetail.weight ?? ""),
          _buildInfo(
              LocaleKeys.general_sender.tr(), detail.senderStep?.name ?? ""),
          _buildInfo(LocaleKeys.general_recipient.tr(),
              detail.recipientStep?.name ?? ""),
          _buildInfo(LocaleKeys.general_additional_services.tr(),
              detail.additionsStep?.shipmentOptionName ?? ""),
        ],
      ),
    );
  }

  Row _buildInfo(String title, String body) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title: title, textType: TextType.body),
        Flexible(
          child: AppText(title: body, textType: TextType.body),
        )
      ],
    );
  }
}
