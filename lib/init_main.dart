import 'package:ase/data/bloc/login/login_cubit.dart';
import 'package:ase/data/bloc/register/register_cubit.dart';
import 'package:ase/data/bloc/resent_code/resent_code_cubit.dart';
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
    ];
  }
}
