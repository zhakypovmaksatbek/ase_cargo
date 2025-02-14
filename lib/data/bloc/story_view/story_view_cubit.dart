import 'package:ase/data/repo/product_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'story_view_state.dart';

class StoryViewCubit extends Cubit<StoryViewState> {
  StoryViewCubit() : super(StoryViewInitial());
  final _repo = ProductRepo();
  Future<void> changeStoryStatus(int storyId) async {
    emit(StoryViewLoading());
    try {
      final response = await _repo.storyViewed(storyId);
      emit(StoryViewSuccess(storyId: storyId, response: response));
    } on DioException catch (e) {
      emit(StoryViewError(
          message: e.response?.data['error'] ??
              LocaleKeys.exception_something_went_wrong_try_again.tr()));
    }
  }
}
