import 'package:ase/core/app_manager.dart';
import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/token_model.dart';
import 'package:ase/init_main.dart';
import 'package:ase/presentation/constants/app_constants.dart';
import 'package:ase/presentation/locale/product_localization.dart';
import 'package:ase/presentation/theme/app_theme.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeApp();
  runApp(ProductLocalizationService(child: await InitMain.init()));
}

Future<void> initializeApp() async {
  // Kullanıcı giriş yapmış mı kontrol et
  final isLoggedIn = await AppManager.instance.getIsLogin();

  if (isLoggedIn) {
    // Token süresi dolmuş mu kontrol et
    final isExpired = await AppManager.instance.isTokenExpired();

    if (isExpired) {
      // Token yenileme işlemini başlat
      try {
        final dioSettings = DioSettings();
        final refreshToken = await AppManager.instance.getRefreshToken();

        if (refreshToken != null && refreshToken.isNotEmpty) {
          final response = await dioSettings.dio.post(
            'v1/auth/token/refresh/',
            data: {'refresh': refreshToken},
          );

          if (response.statusCode == 200) {
            final tokenModel = TokenModel.fromJson(response.data);

            // Yeni tokenları kaydet
            await AppManager.instance
                .setToken(accessToken: tokenModel.access ?? '');

            if (tokenModel.refresh != null && tokenModel.refresh!.isNotEmpty) {
              await AppManager.instance
                  .setRefreshToken(refreshToken: tokenModel.refresh!);
            }

            final expiresIn = tokenModel.expiresIn ?? 3600;
            final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
            await AppManager.instance.setTokenExpiry(expiryTime: expiryTime);

            if (kDebugMode) {
              print('🔄 Uygulama başlatılırken token yenilendi');
            }
          }
        }
      } catch (e) {
        // Token yenileme başarısız, kullanıcıyı logout yap
        await AppManager.instance.setIsLogin(false);
        await AppManager.instance.clearTokens();

        if (kDebugMode) {
          print('❌ Uygulama başlatılırken token yenileme hatası: $e');
        }
      }
    }
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.instance.appName,
      routerConfig: appRouter.config(),
      theme: AppTheme.theme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerLazySingleton<FormDioSettings>(() {
    final dio = FormDioSettings();
    dio.init();
    return dio;
  });
}
