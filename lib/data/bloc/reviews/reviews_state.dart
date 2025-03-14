part of 'reviews_cubit.dart';

sealed class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsSuccess extends ReviewsState {
  final ReviewPaginationModel reviews;

  const ReviewsSuccess({required this.reviews});
}

final class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({required this.message});
}
