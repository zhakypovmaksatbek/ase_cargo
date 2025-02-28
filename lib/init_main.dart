import 'package:ase/data/bloc/banner_bloc/banner_cubit.dart';
import 'package:ase/data/bloc/country/country_cubit.dart';
import 'package:ase/data/bloc/form/form_cubit.dart';
import 'package:ase/data/bloc/form_detail/form_detail_cubit.dart';
import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/login/login_cubit.dart';
import 'package:ase/data/bloc/news/news_cubit.dart';
import 'package:ase/data/bloc/order/order_cubit.dart';
import 'package:ase/data/bloc/register/register_cubit.dart';
import 'package:ase/data/bloc/request/request_cubit.dart';
import 'package:ase/data/bloc/request_detail/request_detail_cubit.dart';
import 'package:ase/data/bloc/resent_code/resent_code_cubit.dart';
import 'package:ase/data/bloc/service/service_cubit.dart';
import 'package:ase/data/bloc/shipment/shipment_cubit.dart';
import 'package:ase/data/bloc/story/story_cubit.dart';
import 'package:ase/data/bloc/story_view/story_view_cubit.dart';
import 'package:ase/data/bloc/update/update_user_cubit.dart';
import 'package:ase/data/bloc/update_password/update_password_cubit.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/data/bloc/verify/verify_cubit.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:ase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class InitMain {
  static Future<Widget> init() async {
    return MultiBlocProvider(
      providers: providers,
      child: MyApp(),
    );
  }

  static List<SingleChildWidget> get providers {
    return [
      BlocProvider(create: (context) => LoginCubit()),
      BlocProvider(create: (context) => RegisterCubit()),
      BlocProvider(create: (context) => VerifyCubit()),
      BlocProvider(create: (context) => ResentCodeCubit()),
      BlocProvider(create: (context) => StoryCubit()),
      BlocProvider(create: (context) => StoryViewCubit()),
      BlocProvider(create: (context) => BannerCubit()),
      BlocProvider(create: (context) => ImagePickerCubit()),
      BlocProvider(create: (context) => UserCubit()),
      BlocProvider(create: (context) => UpdateUserCubit()),
      BlocProvider(create: (context) => NewsCubit()),
      BlocProvider(create: (context) => ServiceCubit()),
      BlocProvider(create: (context) => UpdatePasswordCubit()),
      BlocProvider(create: (context) => FormCubit(FormRepo())),
      BlocProvider(create: (context) => ShipmentCubit()),
      BlocProvider(create: (context) => FormDetailCubit()),
      BlocProvider(create: (context) => OrderCubit(OrderRepo())),
      BlocProvider(create: (context) => RequestCubit(OrderRepo())),
      BlocProvider(create: (context) => CountryCubit(FormRepo())),
      BlocProvider(create: (context) => RequestDetailCubit()),
    ];
  }
}
