part of 'banner_cubit.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerLoaded extends BannerState {
  final HomeModel data;

  const BannerLoaded({required this.data});
}

final class BannerError extends BannerState {
  final String errorMessage;

  const BannerError({required this.errorMessage});
}
