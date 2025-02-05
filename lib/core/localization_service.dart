import 'package:ase/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class ProductLocalizationService extends EasyLocalization {
  ProductLocalizationService({super.key, required super.child})
      : super(
          path: localePath,
          fallbackLocale: Locales.ru.locale,
          startLocale: Locales.ru.locale,
          useOnlyLangCode: true,
          supportedLocales: _supportedLocales,
          assetLoader: const CodegenLoader(),
        );

  static const String localePath = 'assets/translations';
  static final List<Locale> _supportedLocales = [
    //Locales.en.locale,
    Locales.ky.locale,
    Locales.ru.locale
  ];

  // Change project language
  static Future<void> updateLanguage(
          {required BuildContext context, required Locales value}) =>
      context.setLocale(value.locale);
}

// Project locale enum for operation and configuration
enum Locales {
  //en(Locale('en')),
  ky(Locale('ky')),
  ru(Locale('ru'));

  final Locale locale;
  const Locales(this.locale);
}
