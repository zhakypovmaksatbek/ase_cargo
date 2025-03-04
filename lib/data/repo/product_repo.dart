import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/banner_model.dart';
import 'package:ase/data/models/news_model.dart';
import 'package:ase/data/models/service_model.dart';
import 'package:ase/data/models/story_model.dart';
import 'package:dio/dio.dart';

class ProductRepo {
  final _dio = DioSettings();
  Future<List<BannerModel>> getHomeData() async {
    final response = await _dio.get("v1/banners/");
    return (response.data as List).map((e) => BannerModel.fromJson(e)).toList();
  }

  Future<StoryPaginationModel> getStories() async {
    final response = await _dio.get("v1/stories/");
    return StoryPaginationModel.fromJson(response.data);
  }

  Future<String> storyViewed(int storyId) async {
    return "";
  }

  Future<NewsPaginationModel> getNews(int page) async {
    final response =
        await _dio.get("v1/articles/", queryParameters: {"page": page});
    return NewsPaginationModel.fromJson(
      response.data,
    );
  }

  Future<ServicePaginationModel> getServices(int page) async {
    final response =
        await _dio.get("v1/services/", queryParameters: {"page": page});
    return ServicePaginationModel.fromJson(response.data);
  }

  Future<String?> getDetails(String slug, {required String type}) async {
    final Response response = await _dio.get("v1/$type/$slug/content/");
    return response.data["content"] ?? "";
  }
}
