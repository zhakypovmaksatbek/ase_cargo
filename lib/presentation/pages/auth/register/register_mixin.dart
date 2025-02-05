import 'package:ase/main.dart';
import 'package:ase/presentation/pages/auth/register/register_page.dart';
import 'package:ase/presentation/utils/validation.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';

mixin RegisterMixin on State<RegisterPage> {
  final validate = InputValidate.instance;
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> ready = ValueNotifier<bool>(false);
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
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
    router.push(VerifyRoute(phone: countryCode + phoneController.text));
  }
}
