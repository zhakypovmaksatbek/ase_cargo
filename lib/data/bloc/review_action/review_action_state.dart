part of 'review_action_cubit.dart';

sealed class ReviewActionState extends Equatable {
  const ReviewActionState();

  @override
  List<Object> get props => [];
}

final class ReviewActionInitial extends ReviewActionState {}

final class ReviewActionLoading extends ReviewActionState {}

final class ReviewSendSuccess extends ReviewActionState {
  final ReviewModel review;

  const ReviewSendSuccess({required this.review});
}

final class ReviewDeleteSuccess extends ReviewActionState {
  final String code;

  const ReviewDeleteSuccess({required this.code});
}

final class ReviewActionError extends ReviewActionState {
  final String message;

  const ReviewActionError({required this.message});
}
