import 'package:ase/data/bloc/form/form_cubit.dart';
import 'package:ase/data/models/additions_model.dart';
import 'package:ase/data/models/country_model.dart';
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/data/models/sender_model.dart';
import 'package:ase/data/models/shipment_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/order/view/sender_form_view.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SenderFormMixin on State<SenderFormView> {
  final router = getIt<AppRouter>();
  final formKey = GlobalKey<FormState>();
  DeliveryType deliveryType = DeliveryType.parcel;
  double weight = 0;
  final ValueNotifier<int> currentStep = ValueNotifier<int>(0);
  List<CountryModel> countries = [];
  ValueNotifier<List<Packages>> packagesList =
      ValueNotifier<List<Packages>>([]);
  ValueNotifier<PackageErrorInfoModel?> packageErrorInfoModel =
      ValueNotifier<PackageErrorInfoModel?>(null);
  ValueNotifier<SenderModel> sender = ValueNotifier<SenderModel>(SenderModel());
  ValueNotifier<SenderModel> recipient =
      ValueNotifier<SenderModel>(SenderModel());

  ValueNotifier<SenderErrorModel?> senderError =
      ValueNotifier<SenderErrorModel?>(null);
  ValueNotifier<SenderErrorModel?> recipientError =
      ValueNotifier<SenderErrorModel?>(null);
  ValueNotifier<AdditionsModel> addition =
      ValueNotifier<AdditionsModel>(AdditionsModel());
  ValueNotifier<AdditionsErrorModel?> additionError =
      ValueNotifier<AdditionsErrorModel?>(null);
  ValueNotifier<List<ShipmentModel>> shipmentOptions =
      ValueNotifier<List<ShipmentModel>>([]);
  final ValueNotifier<ShipmentModel?> selectedDeliveryType =
      ValueNotifier<ShipmentModel?>(null);
  void cleanErrorMessages() {
    senderError.value = null;
    recipientError.value = null;
    additionError.value = null;
    packageErrorInfoModel.value = null;
  }

  void onContinue(BuildContext context) {
    switch (currentStep.value) {
      case 0:
        sendPackageInfo(context);
        break;
      case 1:
        sendSenderInfo(context);
        break;
      case 2:
        sendRecipientInfo(context);
        break;
      case 3:
        sendAdditionInfo(context);
        break;
    }
  }

  void sendPackageInfo(BuildContext context) {
    context.read<FormCubit>().updatePackageInfo(
        deliveryType == DeliveryType.parcel
            ? PackageInfoModel(
                packagesType: DeliveryType.parcel.name,
                packages: packagesList.value)
            : PackageInfoModel(
                packagesType: DeliveryType.docs.name,
                packages: [Packages(weight: weight)]));
  }

  void sendSenderInfo(BuildContext context) {
    context.read<FormCubit>().updateSender(sender.value);
  }

  void sendRecipientInfo(BuildContext context) {
    context.read<FormCubit>().updateRecipient(recipient.value);
  }

  void sendAdditionInfo(BuildContext context) {
    context.read<FormCubit>().updateAdditions(addition.value);
  }

  String title(int currentStep) {
    switch (currentStep) {
      case 0:
        return LocaleKeys.navigation_fill_delivery_info.tr();
      case 1:
        return LocaleKeys.navigation_fill_sender_info.tr();
      case 2:
        return LocaleKeys.navigation_fill_recipient_info.tr();
      case 3:
        return LocaleKeys.navigation_additional.tr();
      default:
        return LocaleKeys.navigation_fill_delivery_info.tr();
    }
  }
}
