part of 'form_detail_cubit.dart';

sealed class FormDetailState extends Equatable {
  const FormDetailState();

  @override
  List<Object> get props => [];
}

final class FormDetailInitial extends FormDetailState {}

final class FormDetailSuccess extends FormDetailState {
  final FormDetailModel formDetail;
  const FormDetailSuccess(this.formDetail);
}

final class FormDetailError extends FormDetailState {}

final class FormDetailLoading extends FormDetailState {}
