import 'package:ase/data/models/news_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final _repo = ProductRepo();

  Future<void> getNews(int page) async {
    emit(NewsLoading());
    await _repo.getNews(page).then((value) {
      emit(NewsLoaded(news: value));
    }).onError((error, stackTrace) {
      emit(NewsError());
    });
  }
}
