import 'package:ase/generated/codegen_loader.g.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class ProductLocalizationService extends EasyLocalization {
  ProductLocalizationService({super.key, required super.child})
      : super(
          path: AppConstants.localePath,
          fallbackLocale: Locales.ru.locale,
          startLocale: Locales.ru.locale,
          useOnlyLangCode: true,
          supportedLocales: _supportedLocales,
          assetLoader: const CodegenLoader(),
        );

  static final List<Locale> _supportedLocales = [
    //Locales.en.locale,
    // Locales.ky.locale,
    Locales.ru.locale
  ];

  // Change project language
  static Future<void> updateLanguage(
          {required BuildContext context, required Locales value}) =>
      context.setLocale(value.locale);
}

enum Locales {
  // ky(Locale('ky')),
  ru(Locale('ru'), LocaleKeys.general_ru);

  final Locale locale;
  final String name;
  const Locales(this.locale, this.name);
}
