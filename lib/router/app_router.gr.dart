// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreateOrderPage]
class CreateOrderRoute extends PageRouteInfo<void> {
  const CreateOrderRoute({List<PageRouteInfo>? children})
    : super(CreateOrderRoute.name, initialChildren: children);

  static const String name = 'CreateOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateOrderPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [NewsDetailPage]
class NewsDetailRoute extends PageRouteInfo<void> {
  const NewsDetailRoute({List<PageRouteInfo>? children})
    : super(NewsDetailRoute.name, initialChildren: children);

  static const String name = 'NewsDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewsDetailPage();
    },
  );
}

/// generated route for
/// [NewsPage]
class NewsRoute extends PageRouteInfo<void> {
  const NewsRoute({List<PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewsPage();
    },
  );
}

/// generated route for
/// [OnlineChatPage]
class OnlineChatRoute extends PageRouteInfo<void> {
  const OnlineChatRoute({List<PageRouteInfo>? children})
    : super(OnlineChatRoute.name, initialChildren: children);

  static const String name = 'OnlineChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnlineChatPage();
    },
  );
}

/// generated route for
/// [OrderDetailPage]
class OrderDetailRoute extends PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        OrderDetailRoute.name,
        args: OrderDetailRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OrderDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>(
        orElse: () => const OrderDetailRouteArgs(),
      );
      return OrderDetailPage(key: args.key);
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key}';
  }
}

/// generated route for
/// [OrderHistory]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
    : super(OrderHistoryRoute.name, initialChildren: children);

  static const String name = 'OrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderHistory();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [ProfileRouterPage]
class ProfileRouterRoute extends PageRouteInfo<void> {
  const ProfileRouterRoute({List<PageRouteInfo>? children})
    : super(ProfileRouterRoute.name, initialChildren: children);

  static const String name = 'ProfileRouterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileRouterPage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [RequestDetail]
class RequestDetailRoute extends PageRouteInfo<void> {
  const RequestDetailRoute({List<PageRouteInfo>? children})
    : super(RequestDetailRoute.name, initialChildren: children);

  static const String name = 'RequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RequestDetail();
    },
  );
}

/// generated route for
/// [RequestsView]
class RequestsRoute extends PageRouteInfo<void> {
  const RequestsRoute({List<PageRouteInfo>? children})
    : super(RequestsRoute.name, initialChildren: children);

  static const String name = 'RequestsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RequestsView();
    },
  );
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        ResetPasswordRoute.name,
        args: ResetPasswordRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>(
        orElse: () => const ResetPasswordRouteArgs(),
      );
      return ResetPasswordPage(key: args.key);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SenderFormView]
class SenderFormRoute extends PageRouteInfo<void> {
  const SenderFormRoute({List<PageRouteInfo>? children})
    : super(SenderFormRoute.name, initialChildren: children);

  static const String name = 'SenderFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SenderFormView();
    },
  );
}

/// generated route for
/// [ServiceDetailPage]
class ServiceDetailRoute extends PageRouteInfo<void> {
  const ServiceDetailRoute({List<PageRouteInfo>? children})
    : super(ServiceDetailRoute.name, initialChildren: children);

  static const String name = 'ServiceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServiceDetailPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [SupportPage]
class SupportRoute extends PageRouteInfo<void> {
  const SupportRoute({List<PageRouteInfo>? children})
    : super(SupportRoute.name, initialChildren: children);

  static const String name = 'SupportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SupportPage();
    },
  );
}

/// generated route for
/// [TrackingPage]
class TrackingRoute extends PageRouteInfo<void> {
  const TrackingRoute({List<PageRouteInfo>? children})
    : super(TrackingRoute.name, initialChildren: children);

  static const String name = 'TrackingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TrackingPage();
    },
  );
}

/// generated route for
/// [UserInfoPage]
class UserInfoRoute extends PageRouteInfo<void> {
  const UserInfoRoute({List<PageRouteInfo>? children})
    : super(UserInfoRoute.name, initialChildren: children);

  static const String name = 'UserInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserInfoPage();
    },
  );
}

/// generated route for
/// [VerifyPage]
class VerifyRoute extends PageRouteInfo<VerifyRouteArgs> {
  VerifyRoute({
    Key? key,
    required VerifyModel model,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
         VerifyRoute.name,
         args: VerifyRouteArgs(key: key, model: model, title: title),
         initialChildren: children,
       );

  static const String name = 'VerifyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyRouteArgs>();
      return VerifyPage(key: args.key, model: args.model, title: args.title);
    },
  );
}

class VerifyRouteArgs {
  const VerifyRouteArgs({this.key, required this.model, required this.title});

  final Key? key;

  final VerifyModel model;

  final String title;

  @override
  String toString() {
    return 'VerifyRouteArgs{key: $key, model: $model, title: $title}';
  }
}

/// generated route for
/// [ViewsPage]
class ViewsRoute extends PageRouteInfo<void> {
  const ViewsRoute({List<PageRouteInfo>? children})
    : super(ViewsRoute.name, initialChildren: children);

  static const String name = 'ViewsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ViewsPage();
    },
  );
}
