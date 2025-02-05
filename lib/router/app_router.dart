import 'package:ase/presentation/pages/auth/login/login_page.dart';
import 'package:ase/presentation/pages/auth/register/register_page.dart';
import 'package:ase/presentation/pages/auth/verify/verify_page.dart';
import 'package:ase/presentation/pages/splash/splash_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part "app_router.gr.dart";

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true, path: "/splash"),
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(page: RegisterRoute.page, path: "/register"),
        AutoRoute(page: VerifyRoute.page, path: "/verify"),
      ];
}
