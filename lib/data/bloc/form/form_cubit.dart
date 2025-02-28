// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/additions_model.dart';
import 'package:ase/data/models/form_missing_step_model.dart';
import 'package:ase/data/models/package_info_model.dart';
import 'package:ase/data/models/sender_model.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitState> {
  FormCubit(this.repo) : super(FormInitial());

  final IFormRepo repo;
  SenderErrorModel? senderError;
  SenderErrorModel? recipientError;
  AdditionsErrorModel? additionsError;
  PackageErrorInfoModel? packageError;

  Future<void> saveForm() async {
    emit(FormLoading());
    try {
      await repo.saveForm();
      await getIt<FormDioSettings>().clearCookies();
      emit(FormSuccess(steps: FormSteps.finish));
    } catch (e) {
      emit(FormError(errorDetail: e.toString()));
    }
  }

  Future<void> createForm(ShipmentOption userRole) async {
    emit(FormLoading());
    try {
      final result = await repo.createForm(userRole);
      emit(FormSuccess(
        formMissingStepModel: result,
        steps: FormSteps.first,
        userRole: userRole,
      ));
    } on DioException catch (e) {
      emit(FormError(
        errorDetail: e.response?.data['detail'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr(),
      ));
    }
  }

  Future<void> updateSender(SenderModel sender) async {
    emit(FormLoading());
    try {
      await repo.updateSender(sender);
      senderError = null;
      emit(FormSuccess(steps: FormSteps.third));
    } on DioException catch (e) {
      senderError = SenderErrorModel.fromJson(e.response?.data);
      emit(FormError(
        errorDetail: e.response?.data['detail'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr(),
        senderErrorModel: senderError,
      ));
    }
  }

  Future<void> updateRecipient(SenderModel recipient) async {
    emit(FormLoading());
    try {
      await repo.updateRecipient(recipient);
      recipientError = null;
      emit(FormSuccess(steps: FormSteps.fourth));
    } on DioException catch (e) {
      recipientError = SenderErrorModel.fromJson(e.response?.data);
      emit(FormError(
        errorDetail: e.response?.data['detail'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr(),
        recipientErrorModel: recipientError,
      ));
    }
  }

  Future<void> updateAdditions(AdditionsModel additions) async {
    emit(FormLoading());
    try {
      await repo.updateAdditions(additions);
      additionsError = null;
      emit(FormSuccess(steps: FormSteps.fifth));
    } on DioException catch (e) {
      additionsError = AdditionsErrorModel.fromJson(e.response?.data);
      emit(FormError(
        errorDetail: e.response?.data['detail'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr(),
        additionsErrorModel: additionsError,
      ));
    }
  }

  Future<void> updatePackageInfo(PackageInfoModel packageInfo) async {
    emit(FormLoading());
    try {
      await repo.updatePackage(packageInfo);
      packageError = null; // Hata mesajını temizle
      emit(FormSuccess(steps: FormSteps.second));
    } on DioException catch (e) {
      packageError = PackageErrorInfoModel.fromJson(e.response?.data);
      emit(FormError(
        errorDetail: e.response?.data['detail'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr(),
        packageErrorInfoModel: packageError,
      ));
    }
  }

  /// **Tüm hata mesajlarını temizleyen fonksiyon**
  void clearErrorMessages() {
    senderError = null;
    recipientError = null;
    additionsError = null;
    packageError = null;
    if (state is FormError) {
      emit(FormError(
        errorDetail: null,
        senderErrorModel: senderError,
        recipientErrorModel: recipientError,
        additionsErrorModel: additionsError,
        packageErrorInfoModel: packageError,
      ));
    }
  }
}
