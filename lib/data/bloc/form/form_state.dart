part of 'form_cubit.dart';

sealed class FormCubitState extends Equatable {
  const FormCubitState();

  @override
  List<Object> get props => [];
}

final class FormInitial extends FormCubitState {}

final class FormLoading extends FormCubitState {}

final class FormSuccess extends FormCubitState {
  final FormSteps? steps;
  final FormMissingStepModel? formMissingStepModel;

  const FormSuccess({this.steps, this.formMissingStepModel});
}

final class FormError extends FormCubitState {
  final String? errorDetail;
  final SenderErrorModel? senderErrorModel;
  final SenderErrorModel? recipientErrorModel;
  final AdditionsErrorModel? additionsErrorModel;
  final PackageErrorInfoModel? packageErrorInfoModel;

  const FormError(
      {this.errorDetail,
      this.senderErrorModel,
      this.recipientErrorModel,
      this.additionsErrorModel,
      this.packageErrorInfoModel});
}
