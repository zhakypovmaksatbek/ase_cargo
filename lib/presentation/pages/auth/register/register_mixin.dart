import 'package:ase/data/bloc/register/register_cubit.dart';
import 'package:ase/data/models/register_model.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/pages/auth/register/register_page.dart';
import 'package:ase/presentation/utils/validation.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin RegisterMixin on State<RegisterPage> {
  final validate = InputValidate.instance;
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> ready = ValueNotifier<bool>(false);
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String phone = "";
  final router = getIt<AppRouter>();
  String countryCode = "+996";
  void validateForm() {
    if (formKey.currentState!.validate()) {
      ready.value = true;
    } else {
      ready.value = false;
    }
  }

  void onReady() {
   
    context.read<RegisterCubit>().register(RegisterModel(
        phone: phone,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text));
  }
}
