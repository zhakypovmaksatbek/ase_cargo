import 'package:ase/main.dart';
import 'package:ase/presentation/utils/validation.dart';
import 'package:ase/router/app_router.dart';
import 'package:flutter/material.dart';

mixin LoginMixin {
  final validate = InputValidate.instance;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
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
}
