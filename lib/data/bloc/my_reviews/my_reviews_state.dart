part of 'my_reviews_cubit.dart';

sealed class MyReviewsState extends Equatable {
  const MyReviewsState();

  @override
  List<Object> get props => [];
}

final class MyReviewsInitial extends MyReviewsState {}

final class MyReviewsLoading extends MyReviewsState {}

final class MyReviewsSuccess extends MyReviewsState {
  final ReviewPaginationModel reviews;

  const MyReviewsSuccess({required this.reviews});
}

final class MyReviewsError extends MyReviewsState {
  final String message;

  const MyReviewsError({required this.message});
}
