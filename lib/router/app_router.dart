import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/verify_model.dart';
import 'package:ase/presentation/courier/pages/courier_main/courier_main_page.dart';
import 'package:ase/presentation/courier/pages/history/order_history_page.dart';
import 'package:ase/presentation/courier/pages/home/c_home_page.dart';
import 'package:ase/presentation/courier/pages/home/views/signture_page.dart';
import 'package:ase/presentation/courier/pages/profile/c_profile_page.dart';
import 'package:ase/presentation/courier/pages/scan/scan_page.dart';
import 'package:ase/presentation/pages/auth/login/login_page.dart';
import 'package:ase/presentation/pages/auth/register/register_page.dart';
import 'package:ase/presentation/pages/auth/reset_password/reset_password.dart';
import 'package:ase/presentation/pages/auth/reset_password/restore_access_page.dart';
import 'package:ase/presentation/pages/auth/verify/verify_page.dart';
import 'package:ase/presentation/pages/home/home_page.dart';
import 'package:ase/presentation/pages/home/views/news_detail.dart';
import 'package:ase/presentation/pages/home/views/news_page.dart';
import 'package:ase/presentation/pages/home/views/service_detail.dart';
import 'package:ase/presentation/pages/home/views/views_page.dart';
import 'package:ase/presentation/pages/main/main_page.dart';
import 'package:ase/presentation/pages/order/create_order_page.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/order/view/sender_form_view.dart';
import 'package:ase/presentation/pages/profile/views/order/view/order_detail.dart';
import 'package:ase/presentation/pages/profile/views/order/view/order_history.dart';
import 'package:ase/presentation/pages/profile/views/profile_page.dart';
import 'package:ase/presentation/pages/profile/views/requests/payment_page.dart';
import 'package:ase/presentation/pages/profile/views/requests/request_detail.dart';
import 'package:ase/presentation/pages/profile/views/requests/requests_view.dart';
import 'package:ase/presentation/pages/profile/views/user/change_password_page.dart';
import 'package:ase/presentation/pages/profile/views/user/user_info_page.dart';
import 'package:ase/presentation/pages/splash/splash_page.dart';
import 'package:ase/presentation/pages/support/online_chat_page.dart';
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
        AutoRoute(page: OrderDetailRoute.page, path: "/order_detail"),
        AutoRoute(page: SenderFormRoute.page, path: "/sender_form"),
        AutoRoute(page: NewsDetailRoute.page, path: "/news_detail"),
        AutoRoute(page: ServiceDetailRoute.page, path: "/service_detail"),
        AutoRoute(page: ViewsRoute.page, path: "/views"),
        AutoRoute(page: OnlineChatRoute.page, path: "/online_chat"),
        AutoRoute(page: NewsRoute.page, path: "/news_route"),
        AutoRoute(page: PaymentRoute.page, path: "/payment_route"),
        AutoRoute(page: ChangePasswordRoute.page, path: "/change_password"),
        AutoRoute(page: RestoreAccessRoute.page, path: "/reset_access"),
        AutoRoute(page: SignatureRoute.page, path: "/signature"),
        AutoRoute(
            page: COrderHistoryRoute.page, path: "/c_order_history_courier"),
        AutoRoute(
            page: CourierMainRoute.page,
            path: "/courier_main",
            children: [
              AutoRoute(page: CHomeRoute.page, path: "c_home", initial: true),
              AutoRoute(page: CProfileRoute.page, path: "c_profile"),
              AutoRoute(page: ScanRoute.page, path: "scan"),
            ]),
      ];
}

@RoutePage()
class ProfileRouterPage extends AutoRouter {
  const ProfileRouterPage({super.key});
}
