// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:async";

import "package:ase/core/app_manager.dart";
import "package:ase/core/token_interceptor.dart";
import "package:ase/presentation/constants/app_constants.dart";
import "package:cookie_jar/cookie_jar.dart";
import "package:dio/dio.dart";
import "package:dio_cookie_manager/dio_cookie_manager.dart";
import "package:flutter/foundation.dart";
import "package:path_provider/path_provider.dart";

class DioSettings {
  DioSettings() {
    // Önce loglama interceptor'ı ekle
    dio.interceptors.add(DioLoggingInterceptor());
    dio.interceptors.add(TokenInterceptor(tokenDio: dio));

    // Token interceptor için ayrı bir Dio instance'ı oluştur
    final tokenDio = Dio(
      BaseOptions(
        baseUrl: AppConstants.instance.baseUrl,
        headers: {"Accept": "application/json"},
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    // TokenInterceptor'ı ekle
    dio.interceptors.add(TokenInterceptor(tokenDio: tokenDio));

    if (kDebugMode) {
      print('🔧 DioSettings initialized with TokenInterceptor');
    }
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.instance.baseUrl,
      headers: {"Accept": "application/json"},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<Options> _buildOptions() async {
    final String? token = await AppManager.instance.getToken();
    final currentLanguage = await getCurrentLanguage();
    if (kDebugMode) {
      print("====Language ---====");
      //  print(currentLanguage);
    }
    return token != null && token.isNotEmpty
        ? Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept-Language': currentLanguage,
          })
        : Options(headers: {'Accept-Language': currentLanguage});
  }

  Future<Options> _defBuildOptions() async {
    String? currentLanguage = await getCurrentLanguage();

    return Options(
      headers: {'Accept-Language': currentLanguage},
    );
  }

  Future<String> getCurrentLanguage() async {
    String? selectedLanguage = await AppManager.instance.getSelectedLanguage();

    String currentLanguage;
    switch (selectedLanguage) {
      case 'ky':
        currentLanguage = 'ky';
        break;
      case 'ru':
        currentLanguage = 'ru';
        break;

      default:
        currentLanguage = 'ru';
        break;
    }
    return currentLanguage;
  }

  Future<Response> post(String url, Object data) async {
    final Options options = await _buildOptions();
    return dio.post(url, data: data, options: options);
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters, bool? withToken = true}) async {
    final Options options =
        withToken == true ? await _buildOptions() : await _defBuildOptions();

    final Response response =
        await dio.get(url, queryParameters: queryParameters, options: options);

    return response;
  }

  Future<Response> put(String url, Object data) async {
    final Options options = await _buildOptions();
    return dio.put(url, data: data, options: options);
  }

  Future<Response> patch(String url, Object data) async {
    final Options options = await _buildOptions();
    return dio.patch(url, data: data, options: options);
  }

  Future<Response> delete(String url, Object data) async {
    final Options options = await _buildOptions();
    return dio.delete(url, data: data, options: options);
  }
}

class AuthDioSettings {
  AuthDioSettings() {
    dio.interceptors.add(DioLoggingInterceptor());
  }
  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.instance.baseUrl,
      contentType: "application/json",
      headers: {
        "Accept": "application/json",
        "Accept-Language": "ru",
      },
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
}

class DioLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Request ---');
      print('URI: ${options.uri}');
      print('Method: ${options.method}');
      print('Query Parameters: ${options.queryParameters}');
      print('Headers: ${options.headers}');
      print('Request Data: ${options.data}');
      print('---------------------');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Response ---');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('----------------------');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Error ---');
      print('URI: ${err.requestOptions.uri}');
      print('Error: ${err.error}');
      print('Status Code: ${err.response?.statusCode}');
      print('Headers: ${err.response?.headers}');
      print('Response Data: ${err.response?.data}');
      print('---------------------');
    }
    super.onError(err, handler);
  }
}

class FormDioSettings {
  late final CookieJar cookieJar;
  late final Dio dio;

  FormDioSettings._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.instance.baseUrl,
        contentType: "application/json",
        headers: {
          "Accept": "application/json",
          "Accept-Language": "ru",
        },
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(DioLoggingInterceptor());
  }

  static final FormDioSettings _instance = FormDioSettings._internal();
  factory FormDioSettings() => _instance;

  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar =
        PersistCookieJar(storage: FileStorage('${appDocDir.path}/cookies'));

    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<void> clearCookies() async {
    await cookieJar.deleteAll();
  }

  Future<Response> post(String url, Object? data) async {
    return await dio.post(url, data: data, options: await _buildOptions());
  }

  Future<Response> get(String url, {Object? data}) async {
    return await dio.get(url, data: data, options: await _buildOptions());
  }

  Future<Options> _buildOptions() async {
    final String? token = await AppManager.instance.getToken();
    return token != null && token.isNotEmpty
        ? Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept-Language': "ru",
          })
        : Options(headers: {'Accept-Language': "ru"});
  }
}
