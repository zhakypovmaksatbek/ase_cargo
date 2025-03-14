// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CHomePage]
class CHomeRoute extends PageRouteInfo<void> {
  const CHomeRoute({List<PageRouteInfo>? children})
    : super(CHomeRoute.name, initialChildren: children);

  static const String name = 'CHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CHomePage();
    },
  );
}

/// generated route for
/// [COrderHistoryPage]
class COrderHistoryRoute extends PageRouteInfo<void> {
  const COrderHistoryRoute({List<PageRouteInfo>? children})
    : super(COrderHistoryRoute.name, initialChildren: children);

  static const String name = 'COrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const COrderHistoryPage();
    },
  );
}

/// generated route for
/// [CProfilePage]
class CProfileRoute extends PageRouteInfo<void> {
  const CProfileRoute({List<PageRouteInfo>? children})
    : super(CProfileRoute.name, initialChildren: children);

  static const String name = 'CProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CProfilePage();
    },
  );
}

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangePasswordPage();
    },
  );
}

/// generated route for
/// [CourierMainPage]
class CourierMainRoute extends PageRouteInfo<void> {
  const CourierMainRoute({List<PageRouteInfo>? children})
    : super(CourierMainRoute.name, initialChildren: children);

  static const String name = 'CourierMainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CourierMainPage();
    },
  );
}

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
/// [MyReviewsPage]
class MyReviewsRoute extends PageRouteInfo<void> {
  const MyReviewsRoute({List<PageRouteInfo>? children})
    : super(MyReviewsRoute.name, initialChildren: children);

  static const String name = 'MyReviewsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyReviewsPage();
    },
  );
}

/// generated route for
/// [NewsDetailPage]
class NewsDetailRoute extends PageRouteInfo<NewsDetailRouteArgs> {
  NewsDetailRoute({
    Key? key,
    required String slug,
    required String image,
    List<PageRouteInfo>? children,
  }) : super(
         NewsDetailRoute.name,
         args: NewsDetailRouteArgs(key: key, slug: slug, image: image),
         initialChildren: children,
       );

  static const String name = 'NewsDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsDetailRouteArgs>();
      return NewsDetailPage(key: args.key, slug: args.slug, image: args.image);
    },
  );
}

class NewsDetailRouteArgs {
  const NewsDetailRouteArgs({
    this.key,
    required this.slug,
    required this.image,
  });

  final Key? key;

  final String slug;

  final String image;

  @override
  String toString() {
    return 'NewsDetailRouteArgs{key: $key, slug: $slug, image: $image}';
  }
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
class OnlineChatRoute extends PageRouteInfo<OnlineChatRouteArgs> {
  OnlineChatRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
         OnlineChatRoute.name,
         args: OnlineChatRouteArgs(key: key, userId: userId),
         initialChildren: children,
       );

  static const String name = 'OnlineChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnlineChatRouteArgs>();
      return OnlineChatPage(key: args.key, userId: args.userId);
    },
  );
}

class OnlineChatRouteArgs {
  const OnlineChatRouteArgs({this.key, required this.userId});

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'OnlineChatRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [OrderDetailPage]
class OrderDetailRoute extends PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    Key? key,
    required String orderId,
    List<PageRouteInfo>? children,
  }) : super(
         OrderDetailRoute.name,
         args: OrderDetailRouteArgs(key: key, orderId: orderId),
         initialChildren: children,
       );

  static const String name = 'OrderDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>();
      return OrderDetailPage(key: args.key, orderId: args.orderId);
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({this.key, required this.orderId});

  final Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key, orderId: $orderId}';
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
/// [PaymentPage]
class PaymentRoute extends PageRouteInfo<void> {
  const PaymentRoute({List<PageRouteInfo>? children})
    : super(PaymentRoute.name, initialChildren: children);

  static const String name = 'PaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaymentPage();
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
/// [RateAndReviewPage]
class RateAndReviewRoute extends PageRouteInfo<RateAndReviewRouteArgs> {
  RateAndReviewRoute({
    Key? key,
    required String code,
    List<PageRouteInfo>? children,
  }) : super(
         RateAndReviewRoute.name,
         args: RateAndReviewRouteArgs(key: key, code: code),
         initialChildren: children,
       );

  static const String name = 'RateAndReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RateAndReviewRouteArgs>();
      return RateAndReviewPage(key: args.key, code: args.code);
    },
  );
}

class RateAndReviewRouteArgs {
  const RateAndReviewRouteArgs({this.key, required this.code});

  final Key? key;

  final String code;

  @override
  String toString() {
    return 'RateAndReviewRouteArgs{key: $key, code: $code}';
  }
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
class RequestDetailRoute extends PageRouteInfo<RequestDetailRouteArgs> {
  RequestDetailRoute({Key? key, required int id, List<PageRouteInfo>? children})
    : super(
        RequestDetailRoute.name,
        args: RequestDetailRouteArgs(key: key, id: id),
        initialChildren: children,
      );

  static const String name = 'RequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestDetailRouteArgs>();
      return RequestDetail(key: args.key, id: args.id);
    },
  );
}

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'RequestDetailRouteArgs{key: $key, id: $id}';
  }
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
/// [RestoreAccessPage]
class RestoreAccessRoute extends PageRouteInfo<void> {
  const RestoreAccessRoute({List<PageRouteInfo>? children})
    : super(RestoreAccessRoute.name, initialChildren: children);

  static const String name = 'RestoreAccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RestoreAccessPage();
    },
  );
}

/// generated route for
/// [ScanDetailPage]
class ScanDetailRoute extends PageRouteInfo<ScanDetailRouteArgs> {
  ScanDetailRoute({
    Key? key,
    required String orderCode,
    List<PageRouteInfo>? children,
  }) : super(
         ScanDetailRoute.name,
         args: ScanDetailRouteArgs(key: key, orderCode: orderCode),
         initialChildren: children,
       );

  static const String name = 'ScanDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScanDetailRouteArgs>();
      return ScanDetailPage(key: args.key, orderCode: args.orderCode);
    },
  );
}

class ScanDetailRouteArgs {
  const ScanDetailRouteArgs({this.key, required this.orderCode});

  final Key? key;

  final String orderCode;

  @override
  String toString() {
    return 'ScanDetailRouteArgs{key: $key, orderCode: $orderCode}';
  }
}

/// generated route for
/// [ScanPage]
class ScanRoute extends PageRouteInfo<void> {
  const ScanRoute({List<PageRouteInfo>? children})
    : super(ScanRoute.name, initialChildren: children);

  static const String name = 'ScanRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScanPage();
    },
  );
}

/// generated route for
/// [SenderFormView]
class SenderFormRoute extends PageRouteInfo<SenderFormRouteArgs> {
  SenderFormRoute({
    Key? key,
    required ShipmentOption userRole,
    List<PageRouteInfo>? children,
  }) : super(
         SenderFormRoute.name,
         args: SenderFormRouteArgs(key: key, userRole: userRole),
         initialChildren: children,
       );

  static const String name = 'SenderFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SenderFormRouteArgs>();
      return SenderFormView(key: args.key, userRole: args.userRole);
    },
  );
}

class SenderFormRouteArgs {
  const SenderFormRouteArgs({this.key, required this.userRole});

  final Key? key;

  final ShipmentOption userRole;

  @override
  String toString() {
    return 'SenderFormRouteArgs{key: $key, userRole: $userRole}';
  }
}

/// generated route for
/// [ServiceDetailPage]
class ServiceDetailRoute extends PageRouteInfo<ServiceDetailRouteArgs> {
  ServiceDetailRoute({
    Key? key,
    required String slug,
    required String image,
    List<PageRouteInfo>? children,
  }) : super(
         ServiceDetailRoute.name,
         args: ServiceDetailRouteArgs(key: key, slug: slug, image: image),
         initialChildren: children,
       );

  static const String name = 'ServiceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceDetailRouteArgs>();
      return ServiceDetailPage(
        key: args.key,
        slug: args.slug,
        image: args.image,
      );
    },
  );
}

class ServiceDetailRouteArgs {
  const ServiceDetailRouteArgs({
    this.key,
    required this.slug,
    required this.image,
  });

  final Key? key;

  final String slug;

  final String image;

  @override
  String toString() {
    return 'ServiceDetailRouteArgs{key: $key, slug: $slug, image: $image}';
  }
}

/// generated route for
/// [SignaturePage]
class SignatureRoute extends PageRouteInfo<SignatureRouteArgs> {
  SignatureRoute({
    Key? key,
    required BoxModel box,
    List<PageRouteInfo>? children,
  }) : super(
         SignatureRoute.name,
         args: SignatureRouteArgs(key: key, box: box),
         initialChildren: children,
       );

  static const String name = 'SignatureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignatureRouteArgs>();
      return SignaturePage(key: args.key, box: args.box);
    },
  );
}

class SignatureRouteArgs {
  const SignatureRouteArgs({this.key, required this.box});

  final Key? key;

  final BoxModel box;

  @override
  String toString() {
    return 'SignatureRouteArgs{key: $key, box: $box}';
  }
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
