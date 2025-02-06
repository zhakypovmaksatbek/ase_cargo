// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ru = {
  "button": {
    "login": "Войти",
    "signup": "Зарегистрироваться",
    "continue": "Продолжить",
    "next": "Следующий",
    "back": "Назад",
    "cancel": "Отмена",
    "save": "Сохранить",
    "delete": "Удалить",
    "edit": "Изменить",
    "add": "Добавить",
    "close": "Закрыть",
    "search": "Поиск",
    "filter": "Фильтр",
    "sort": "Сортировать",
    "reset": "Сбросить",
    "apply": "Применить",
    "skip": "Пропустить",
    "confirm": "Подтвердить",
    "forgot_password": "Забыли пароль?",
    "resend_code": "Отправить код повторно"
  },
  "form": {
    "phone_number": "Номер телефона",
    "password": "Пароль",
    "confirm_password": "Подтвердите пароль",
    "new_password": "Новый пароль",
    "confirm_new_password": "Подтвердите новый пароль",
    "old_password": "Старый пароль",
    "first_name": "Имя",
    "last_name": "Фамилия",
    "email": "Email",
    "code": "Код",
    "code_hint": "Введите код из смс",
    "code_error": "Код неверный",
    "signup_policy_text": "Нажимая Зарегистрироваться вы принимаете Политику конфиденциальности",
    "have_account": "Есть аккаунт? Войдите",
    "no_account": "Нет аккаунта? Зарегистрируйтесь",
    "confirm_phone_number": "Подтвердите номер телефона",
    "restore_access": "Восстоновление доступа"
  },
  "exception": {
    "cannot_be_empty": "Не может быть пустым",
    "password_min_character": "Минимальное количество символов 6",
    "password_not_match": "Пароли не совпадают",
    "invalid_phone_number": "Неверный номер телефона"
  },
  "notification": {
    "we_sent_code_to_your_phone": "Мы отправили код на указанный вами номер"
  },
  "general": {
    "seconds": "сек",
    "create_new_password": "Придумайте новый пароль"
  },
  "navigation": {
    "verify": "Подтверждение",
    "reset_password": "Изменение пароля",
    "home": "Главная"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": _ru};
}
