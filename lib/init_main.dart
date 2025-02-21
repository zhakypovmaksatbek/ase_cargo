import 'package:ase/data/bloc/banner_bloc/banner_cubit.dart';
import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/login/login_cubit.dart';
import 'package:ase/data/bloc/register/register_cubit.dart';
import 'package:ase/data/bloc/resent_code/resent_code_cubit.dart';
import 'package:ase/data/bloc/story/story_cubit.dart';
import 'package:ase/data/bloc/story_view/story_view_cubit.dart';
import 'package:ase/data/bloc/update/update_user_cubit.dart';
import 'package:ase/data/bloc/user_cubit/user_cubit.dart';
import 'package:ase/data/bloc/verify/verify_cubit.dart';
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
    ];
  }
}
