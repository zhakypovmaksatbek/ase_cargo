import 'package:ase/data/models/review_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_reviews_state.dart';

class MyReviewsCubit extends Cubit<MyReviewsState> {
  MyReviewsCubit() : super(MyReviewsInitial());

  Future<void> getMyReviews(int page) async {
    emit(MyReviewsLoading());
    try {
      final response = await ProductRepo().getMyReviews(page);
      emit(MyReviewsSuccess(reviews: response));
    } on DioException catch (e) {
      emit(MyReviewsError(message: e.toString()));
    }
  }
}
