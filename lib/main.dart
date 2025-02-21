import 'package:ase/core/localization_service.dart';
import 'package:ase/init_main.dart';
import 'package:ase/presentation/constants/app_constants.dart';
import 'package:ase/presentation/theme/app_theme.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(ProductLocalizationService(child: await InitMain.init()));
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
}
