import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/banner_model.dart';
import 'package:ase/data/models/news_model.dart';
import 'package:ase/data/models/review_model.dart';
import 'package:ase/data/models/service_model.dart';
import 'package:ase/data/models/story_model.dart';
import 'package:dio/dio.dart';

class ProductRepo implements IProductRepo {
  final _dio = DioSettings();
  @override
  Future<List<BannerModel>> getHomeData() async {
    final response = await _dio.get("v1/banners/", withToken: false);
    return (response.data as List).map((e) => BannerModel.fromJson(e)).toList();
  }

  @override
  Future<StoryPaginationModel> getStories() async {
    final response = await _dio.get("v1/stories/");
    return StoryPaginationModel.fromJson(response.data);
  }

  @override
  Future<String> storyViewed(int storyId) async {
    return "";
  }

  @override
  Future<NewsPaginationModel> getNews(int page) async {
    final response = await _dio.get("v1/articles/",
        queryParameters: {"page": page}, withToken: false);
    return NewsPaginationModel.fromJson(response.data);
  }

  @override
  Future<ServicePaginationModel> getServices(int page) async {
    final response = await _dio.get("v1/services/",
        queryParameters: {"page": page}, withToken: false);
    return ServicePaginationModel.fromJson(response.data);
  }

  @override
  Future<String?> getDetails(String slug, {required String type}) async {
    final Response response = await _dio.get("v1/$type/$slug/content/");
    return response.data["content"] ?? "";
  }

  @override
  Future<ReviewPaginationModel> getReviews(int page) async {
    final response = await _dio.get("v1/reviews/",
        queryParameters: {"page": page}, withToken: false);
    return ReviewPaginationModel.fromJson(response.data);
  }

  @override
  Future<ReviewPaginationModel> getMyReviews(int page) async {
    final response = await _dio
        .get("v1/logistics/reviews/", queryParameters: {"page": page});
    return ReviewPaginationModel.fromJson(response.data);
  }

  @override
  Future<ReviewModel> sendReview(
      {required ReviewModel review, required String orderCode}) async {
    final formData = await review.toFormData();
    final response = await _dio.post("v1/logistics/orders/$orderCode/review/",
        data: formData);
    return ReviewModel.fromJson(response.data);
  }

  @override
  Future<void> deleteReview(String code) async {
    await _dio.delete("v1/logistics/orders/$code/review/");
  }
}

abstract class IProductRepo {
  Future<List<BannerModel>> getHomeData();

  Future<StoryPaginationModel> getStories();

  Future<String> storyViewed(int storyId);

  Future<NewsPaginationModel> getNews(int page);

  Future<ServicePaginationModel> getServices(int page);

  Future<String?> getDetails(String slug, {required String type});

  Future<ReviewPaginationModel> getReviews(int page);

  Future<ReviewPaginationModel> getMyReviews(int page);

  Future<ReviewModel> sendReview({
    required ReviewModel review,
    required String orderCode,
  });

  Future<void> deleteReview(String code);
}
