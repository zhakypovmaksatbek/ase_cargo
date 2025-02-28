import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/additions_model.dart';
import 'package:ase/data/models/country_model.dart';
import 'package:ase/data/models/form_detail_model.dart';
import 'package:ase/data/models/form_missing_step_model.dart';
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/data/models/sender_model.dart';
import 'package:ase/data/models/shipment_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:dio/dio.dart';

final class FormRepo implements IFormRepo {
  final dio = getIt<FormDioSettings>();

  @override
  Future<FormMissingStepModel> createForm(ShipmentOption userRole) async {
    final Response response = await dio.post(
        "v1/logistics/preorders/steps/initial/", {"user_role": userRole.name});
    return FormMissingStepModel.fromJson(response.data);
  }

  @override
  Future<void> updateAdditions(AdditionsModel additions) async {
    await dio.post(
        "v1/logistics/preorders/steps/additions/", additions.toJson());
  }

  @override
  Future<void> updatePackage(PackageInfoModel package) async {
    final parameter = package.packagesType == "parcel"
        ? package.toJson()
        : package.documentToJson();
    await dio.post("v1/logistics/preorders/steps/packages/", parameter);
  }

  @override
  Future<void> updateRecipient(SenderModel recipient) async {
    if (recipient.entityType == "individual") {
      FormData requestData = await SenderModel.physicalToFormData(recipient);
      await dio.post("v1/logistics/preorders/steps/recipient/", requestData);
    } else {
      await dio.post(
          "v1/logistics/preorders/steps/recipient/", recipient.legalToJson());
    }
  }

  @override
  Future<void> updateSender(SenderModel sender) async {
    if (sender.entityType == "individual") {
      FormData requestData = await SenderModel.physicalToFormData(sender);
      await dio.post("v1/logistics/preorders/steps/sender/", requestData);
    } else {
      await dio.post(
          "v1/logistics/preorders/steps/sender/", sender.legalToJson());
    }
  }

  @override
  Future<List<ShipmentModel>> getShipmentOptions(
      ShipmentOption userRole) async {
    final response = await dio
        .get("v1/logistics/shipment-options/?option_type=${userRole.name}");
    return (response.data as List)
        .map((e) => ShipmentModel.fromJson(e))
        .toList();
  }

  @override
  Future<FormDetailModel> getFormDetail() async {
    final Response response = await dio.get("v1/logistics/preorders/steps/");
    return FormDetailModel.fromJson(response.data);
  }

  @override
  Future<void> saveForm() async {
    await dio.post("v1/logistics/preorders/steps/save/", {});
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await dio.get("v1/logistics/countries/");
    return (response.data as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  }
}

abstract class IFormRepo {
  Future<FormMissingStepModel> createForm(ShipmentOption userRole);
  Future<void> updatePackage(PackageInfoModel package);
  Future<void> updateSender(SenderModel sender);
  Future<void> updateRecipient(SenderModel recipient);
  Future<void> updateAdditions(AdditionsModel additions);
  Future<List<ShipmentModel>> getShipmentOptions(ShipmentOption userRole);
  Future<List<CountryModel>> getCountries();
  Future<FormDetailModel> getFormDetail();
  Future<void> saveForm();
}
