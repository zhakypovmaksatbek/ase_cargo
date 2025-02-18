import 'package:ase/data/models/verify_model.dart';
import 'package:ase/presentation/pages/auth/login/login_page.dart';
import 'package:ase/presentation/pages/auth/register/register_page.dart';
import 'package:ase/presentation/pages/auth/reset_password/reset_password.dart';
import 'package:ase/presentation/pages/auth/verify/verify_page.dart';
import 'package:ase/presentation/pages/home/home_page.dart';
import 'package:ase/presentation/pages/main/main_page.dart';
import 'package:ase/presentation/pages/order/create_order_page.dart';
import 'package:ase/presentation/pages/profile/views/order/view/order_history.dart';
import 'package:ase/presentation/pages/profile/views/profile_page.dart';
import 'package:ase/presentation/pages/profile/views/requests/request_detail.dart';
import 'package:ase/presentation/pages/profile/views/requests/requests_view.dart';
import 'package:ase/presentation/pages/profile/views/user/user_info_page.dart';
import 'package:ase/presentation/pages/splash/splash_page.dart';
import 'package:ase/presentation/pages/support/support_page.dart';
import 'package:ase/presentation/pages/tracking/tracking_page.dart';
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
        AutoRoute(page: ResetPasswordRoute.page, path: "/reset_password"),
        AutoRoute(page: MainRoute.page, path: "/main", children: [
          AutoRoute(page: HomeRoute.page, path: "home", initial: true),
          AutoRoute(page: CreateOrderRoute.page, path: "create_order"),
          AutoRoute(page: SupportRoute.page, path: "support"),
          AutoRoute(page: TrackingRoute.page, path: "tracking"),
          AutoRoute(
              page: ProfileRouterRoute.page,
              path: "profileRouter",
              children: [
                AutoRoute(
                    page: ProfileRoute.page, path: "profile", initial: true),
              ]),
        ]),
        AutoRoute(page: RequestsRoute.page, path: "/requests"),
        AutoRoute(page: RequestDetailRoute.page, path: "/request_detail"),
        AutoRoute(page: UserInfoRoute.page, path: "/user_info"),
        AutoRoute(page: OrderHistoryRoute.page, path: "/order_history"),
      ];
}

@RoutePage()
class ProfileRouterPage extends AutoRouter {
  const ProfileRouterPage({super.key});
}
