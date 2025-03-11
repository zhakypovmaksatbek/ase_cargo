import 'package:ase/core/app_manager.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "SplashRoute")
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  final router = getIt<AppRouter>();
  Future<void> _navigateToLogin() async {
    bool isLogin = await AppManager.instance.getIsLogin();
    String? role = await AppManager.instance.getUserRole();
    await Future.delayed(const Duration(seconds: 3), () {
      if (isLogin) {
        if (role == "courier") {
          router.replace(const CourierMainRoute());
        } else {
          router.replace(const MainRoute());
        }
      } else {
        router.replace(const LoginRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 80,
          children: [
            Center(
              child: CustomAssetImage(
                path: AssetConstants.logo.png,
                width: 100,
                height: 100,
              ),
            ),
            Center(
              child: CustomAssetImage(
                path: AssetConstants.splash.png,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
