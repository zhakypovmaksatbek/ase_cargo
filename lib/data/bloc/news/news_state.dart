part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoaded extends NewsState {
  final NewsPaginationModel news;
  const NewsLoaded({required this.news});
}

final class NewsError extends NewsState {}

final class NewsLoading extends NewsState {}
