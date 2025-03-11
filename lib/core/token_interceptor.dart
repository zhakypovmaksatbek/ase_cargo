import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/token_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TokenInterceptor extends Interceptor {
  final Dio tokenDio;

  TokenInterceptor(
      {required this.tokenDio}); // Token yenileme için ayrı bir Dio instance'ı

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Auth istekleri için token kontrolünü atla
    if (options.path.contains('v1/auth/token/') ||
        options.path.contains('v1/auth/token/refresh/')) {
      if (kDebugMode) {
        print('⏩ Auth isteği, token kontrolü atlanıyor: ${options.path}');
      }
      return handler.next(options);
    }

    // Kullanıcı giriş yapmış mı kontrol et
    final isLogin = await AppManager.instance.getIsLogin() ?? false;

    if (isLogin) {
      // Token kontrolü
      if (await _shouldRefreshToken()) {
        try {
          // Token yenile
          await _refreshToken();
        } catch (e) {
          // Token yenileme başarısız, kullanıcıyı logout yap
          await AppManager.instance.setIsLogin(false);
          await AppManager.instance.clearTokens();

          if (kDebugMode) {
            print('❌ Token yenileme başarısız: $e');
          }

          // Token hatası olsa da isteğe devam et
          return handler.next(options);
        }
      }

      // Güncel token'ı ekle
      final token = await AppManager.instance.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        // Token yoksa veya boşsa, token'ları temizle
        await AppManager.instance.clearTokens();
      }
    }

    // Dil ayarını ekle
    final currentLanguage =
        await AppManager.instance.getSelectedLanguage() ?? 'ru';
    options.headers['Accept-Language'] = currentLanguage;

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 hatası (Unauthorized) - Token geçersiz veya süresi dolmuş
    if (err.response?.statusCode == 401) {
      try {
        // Token yenile
        await _refreshToken();

        // Orijinal isteği yeni token ile tekrarla
        final token = await AppManager.instance.getToken();
        final opts = Options(
          method: err.requestOptions.method,
          headers: {
            ...err.requestOptions.headers,
            'Authorization': 'Bearer $token',
          },
        );

        final response = await tokenDio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        // Token yenileme başarısız, kullanıcıyı logout yap
        await AppManager.instance.setIsLogin(false);
        await AppManager.instance.clearTokens();
      }
    }

    return handler.next(err);
  }

  Future<bool> _shouldRefreshToken() async {
    // Token süresi dolmuşsa true döndür
    return await AppManager.instance.isTokenExpired();
  }

  Future<void> _refreshToken() async {
    final refreshToken = await AppManager.instance.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      if (kDebugMode) {
        print('❌ Refresh token bulunamadı');
      }
      await AppManager.instance.setIsLogin(false);
      // throw Exception('Refresh token bulunamadı');
    }

    try {
      if (kDebugMode) {
        print('🔄 Token yenileme isteği gönderiliyor');
        print('🔄 Refresh Token: $refreshToken');
      }

      // Token yenileme isteği
      final response = await tokenDio.post(
        'v1/auth/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (kDebugMode) {
        print('🔄 Token yenileme yanıtı: ${response.statusCode}');
        print('🔄 Yanıt verisi: ${response.data}');
      }

      if (response.statusCode == 200) {
        final tokenModel = TokenModel.fromJson(response.data);

        // Yeni tokenları kaydet
        await AppManager.instance
            .setToken(accessToken: tokenModel.access ?? '');

        // Refresh token da yenilendiyse onu da kaydet
        if (tokenModel.refresh != null && tokenModel.refresh!.isNotEmpty) {
          await AppManager.instance
              .setRefreshToken(refreshToken: tokenModel.refresh!);
        }

        // Token süresini hesapla ve kaydet
        final expiresIn = tokenModel.expiresIn ?? 3600; // Varsayılan 1 saat
        final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
        await AppManager.instance.setTokenExpiry(expiryTime: expiryTime);

        if (kDebugMode) {
          print('✅ Token başarıyla yenilendi');
        }
      } else {
        if (kDebugMode) {
          print('❌ Token yenileme başarısız: ${response.statusCode}');
          print('❌ Yanıt verisi: ${response.data}');
        }
        throw Exception('Token yenileme başarısız: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Token yenileme hatası: $e');
      }
      throw Exception('Token yenileme hatası: $e');
    }
  }

  // Test amaçlı manuel token yenileme metodu
  Future<bool> testRefreshToken() async {
    try {
      final refreshToken = await AppManager.instance.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        if (kDebugMode) {
          print('❌ Test: Refresh token bulunamadı');
        }
        return false;
      }

      if (kDebugMode) {
        print('🔄 Test: Token yenileme isteği gönderiliyor');
        print('🔄 Test: Refresh Token: $refreshToken');
      }

      // Farklı endpoint seçeneklerini deneyin
      final endpoints = [
        'v1/auth/token/refresh/',
        'v1/auth/refresh/',
        'v1/auth/token/refresh',
        'auth/token/refresh/',
      ];

      for (final endpoint in endpoints) {
        try {
          if (kDebugMode) {
            print('🔄 Test: Endpoint deneniyor: $endpoint');
          }

          final response = await tokenDio.post(
            endpoint,
            data: {'refresh': refreshToken},
          );

          if (response.statusCode == 200) {
            if (kDebugMode) {
              print('✅ Test: Token başarıyla yenilendi (Endpoint: $endpoint)');
              print('✅ Test: Yanıt: ${response.data}');
            }
            return true;
          } else {
            if (kDebugMode) {
              print(
                  '❌ Test: Token yenileme başarısız: ${response.statusCode} (Endpoint: $endpoint)');
              print('❌ Test: Yanıt: ${response.data}');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('❌ Test: Endpoint hatası: $e (Endpoint: $endpoint)');
          }
        }
      }

      // Alternatif veri formatlarını deneyin
      final dataFormats = [
        {'refresh': refreshToken},
        {'refresh_token': refreshToken},
        {'token': refreshToken},
      ];

      for (final data in dataFormats) {
        try {
          if (kDebugMode) {
            print('🔄 Test: Veri formatı deneniyor: $data');
          }

          final response = await tokenDio.post(
            'v1/auth/token/refresh/',
            data: data,
          );

          if (response.statusCode == 200) {
            if (kDebugMode) {
              print('✅ Test: Token başarıyla yenilendi (Veri formatı: $data)');
              print('✅ Test: Yanıt: ${response.data}');
            }
            return true;
          } else {
            if (kDebugMode) {
              print(
                  '❌ Test: Token yenileme başarısız: ${response.statusCode} (Veri formatı: $data)');
              print('❌ Test: Yanıt: ${response.data}');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('❌ Test: Veri formatı hatası: $e (Veri formatı: $data)');
          }
        }
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Test: Genel hata: $e');
      }
      return false;
    }
  }
}
