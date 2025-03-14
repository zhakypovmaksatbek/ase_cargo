import 'package:ase/data/models/review_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());

  Future<void> getReviews(int page) async {
    emit(ReviewsLoading());
    try {
      final response = await ProductRepo().getReviews(page);
      emit(ReviewsSuccess(reviews: response));
    } on DioException catch (e) {
      emit(ReviewsError(message: e.toString()));
    }
  }
}
