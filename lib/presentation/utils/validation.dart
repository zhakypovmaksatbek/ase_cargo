import 'package:ase/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

final class InputValidate {
  InputValidate._();
  static InputValidate instance = InputValidate._();
  final regexPassword = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])');
  final regexEmail = RegExp(r'^(?=.*?[a-z])(?=.*?[!@#\$&*~])');

  String? validateGeneral(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.exception_cannot_be_empty.tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    final passNonNullValue = value ?? '';
    if (value!.isEmpty) {
      return LocaleKeys.exception_cannot_be_empty.tr();
    } else if (passNonNullValue.length < 5) {
      return LocaleKeys.exception_password_min_character.tr();
    } else if (!regexEmail.hasMatch(passNonNullValue)) {
      return LocaleKeys.exception_password_min_character.tr();
    }
    return null;
  }

  String? validatePassword(String? value) {
    final passNonNullValue = value ?? '';
    if (value!.isEmpty) {
      return LocaleKeys.exception_cannot_be_empty.tr();
    } else if (passNonNullValue.length < 6) {
      return LocaleKeys.exception_password_min_character.tr();
    } else if (!regexPassword.hasMatch(passNonNullValue)) {
      return LocaleKeys.exception_password_min_character.tr();
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value != password) {
      return LocaleKeys.exception_password_not_match.tr();
    }
    return null;
  }
}
