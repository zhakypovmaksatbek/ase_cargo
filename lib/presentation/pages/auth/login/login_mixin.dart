import 'package:ase/data/bloc/login/login_cubit.dart';
import 'package:ase/data/models/login_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/products/utils/validation.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin LoginMixin {
  final validate = InputValidate.instance;
  final formKey = GlobalKey<FormState>();
  String phone = "";
  final passwordController = TextEditingController();
  final router = getIt<AppRouter>();
  final ValueNotifier<bool> ready = ValueNotifier<bool>(false);
  void validateForm() {
    if (formKey.currentState!.validate()) {
      ready.value = true;
    } else {
      ready.value = false;
    }
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (ready.value == true) {
        context.read<LoginCubit>().login(LoginModel(
              phone: phone,
              password: passwordController.text,
            ));
      }
    } else {
      ready.value = false;
    }
  }
}
