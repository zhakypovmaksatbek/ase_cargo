import 'package:ase/presentation/products/utils/validation.dart';
import 'package:flutter/material.dart';

mixin UserInfoMixin {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final validate = InputValidate.instance;
}
