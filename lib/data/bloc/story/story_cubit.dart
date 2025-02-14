import 'package:ase/data/repo/product_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/story_model.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());
  final _repo = ProductRepo();

  Future<void> getStories() async {
    emit(StoryLoading());
    try {
      final stories = await _repo.getStories();
      emit(StoryLoaded(stories: stories));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await AppManager.instance.setToken(accessToken: '');
        await AppManager.instance.setIsLogin(false);
      }
      emit(StoryError(
          message: e.response?.data['error'] ??
              LocaleKeys.exception_something_went_wrong_try_again.tr()));
    } catch (e) {
      emit(StoryError(message: e.toString()));
    }
  }
}
