import 'package:ase/data/models/review_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_action_state.dart';

class ReviewActionCubit extends Cubit<ReviewActionState> {
  ReviewActionCubit() : super(ReviewActionInitial());

  Future<void> sendReview(ReviewModel review, String orderCode) async {
    emit(ReviewActionLoading());
    try {
      final response =
          await ProductRepo().sendReview(review: review, orderCode: orderCode);
      emit(ReviewSendSuccess(review: response));
    } on DioException catch (e) {
      emit(ReviewActionError(message: e.toString()));
    }
  }

  Future<void> deleteReview(String code) async {
    emit(ReviewActionLoading());
    try {
      await ProductRepo().deleteReview(code);
      emit(ReviewDeleteSuccess(code: code));
    } on DioException catch (e) {
      emit(ReviewActionError(message: e.toString()));
    }
  }
}
