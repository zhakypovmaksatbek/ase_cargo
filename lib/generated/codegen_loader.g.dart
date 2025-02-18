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
    "resend_code": "Отправить код повторно",
    "read_more": "Читать ещё",
    "read_less": "Читать меньше",
    "logout": "Выйти из профиля",
    "delete_account": "Удалить профиль",
    "exit": "Выйти",
    "ok": "Ок",
    "filters": "Фильтры",
    "next_step": "Далее"
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
    "restore_access": "Восстоновление доступа",
    "name_field": "Наименование",
    "description": "Описание",
    "weight": "Вес:",
    "price_product": "Стоимость товара",
    "dimensions": "Габариты",
    "length": "Длина в см",
    "width": "Ширина в см",
    "height": "Высота в см",
    "enter_document_info": "Введите информацию о документе:",
    "passport_data": "Паспортные данные",
    "inn": "ИНН",
    "date_issue": "Дата выдачи",
    "who_issue": "Кем выдан?",
    "upload_passport": "Загрузите фотографию паспорта",
    "upload_back_passport": "Загрузите фото обратной стороны паспорта",
    "upload_photo": "Загрузите фото",
    "contact_data": "Контактные данные",
    "country": "Страна",
    "city": "Город",
    "street": "Улица",
    "address": "Улица / Дом / Кв",
    "index": "Почтовый индекс",
    "save_data": "Сохранить данные",
    "region": "Район"
  },
  "exception": {
    "cannot_be_empty": "Не может быть пустым",
    "password_min_character": "Минимальное количество символов 6",
    "password_not_match": "Пароли не совпадают",
    "invalid_phone_number": "Неверный номер телефона",
    "exception": "Ошибка",
    "something_went_wrong_try_again": "Что-то пошло не так, попробуйте еще раз",
    "no_internet": "На вашем устройстве нет интернета",
    "unknown_error": "Неизвестная ошибка",
    "unexpected_error": "Непредвиденная ошибка"
  },
  "notification": {
    "we_sent_code_to_your_phone": "Мы отправили код на указанный вами номер",
    "exit_account": "Вы действительно хотите выйти из своего аккаунта?",
    "no_orders": "У вас нет заявок...",
    "order_will_be_shipped": "Ваш заказ будет отправлен в ближайшее время!"
  },
  "general": {
    "seconds": "сек",
    "create_new_password": "Придумайте новый пароль",
    "news": "Новости",
    "our_services": "Наши услуги",
    "read_reviews": "Читайте отзывы о нас",
    "questions_and_answers": "Вопросы и ответы",
    "reviews": "Отзывы",
    "delivery_address": "Адрес доставки",
    "status_order": "Статус заказа:",
    "delivery_type": "Тип доставки:",
    "weight": "Вес:",
    "service_price": "Цена за услугу:",
    "additional_service_price": "Цена за доп. услугу:",
    "pay": "Оплатить",
    "waiting_payment": "Ожидает оплаты",
    "processing": "Обрабатывается",
    "canceled": "Отменён",
    "select": "Выбрать",
    "delivery_info": "Информация о посылке:",
    "additional_services": "Доп. услуги:",
    "sender": "Отправитель:",
    "recipient": "Получатель:",
    "paid": "Оплачено:",
    "by_sender": "Отправителем",
    "by_recipient": "Получателем",
    "date": "Дата:",
    "i_sender": "Я отправитель",
    "i_recipient": "Я получатель",
    "new_order": "Новый заказ",
    "select_role": "Выберите свою роль, чтобы продолжить",
    "delivery": "Посылка",
    "document": "Документ",
    "enter_info": "Введите информацию о посылке:"
  },
  "navigation": {
    "verify": "Подтверждение",
    "reset_password": "Изменение пароля",
    "home": "Главная",
    "notifications": "Уведомления",
    "profile": "Профиль",
    "tracking": "Трекинг",
    "cabinet": "Кабинет",
    "support": "Поддержка",
    "requests": "Заявки",
    "my_reviews": "Мои отзывы",
    "language": "Язык",
    "userInfo": "Личные данные",
    "aboutApp": "О приложении",
    "termsOfUse": "Условия использования",
    "order_history": "История заказов",
    "order_details": "Детали заказа",
    "request_detail": "Детали заявки",
    "sender": "Отправитель",
    "recipient": "Получатель",
    "fill_delivery_info": "Заполните детали доставки"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": _ru};
}
