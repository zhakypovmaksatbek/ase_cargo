import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: "EuclidCircular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        primaryColor: ColorConstants.primary,
        scaffoldBackgroundColor: ColorConstants.backgroundLight,
        hintColor: ColorConstants.grey,
        canvasColor: ColorConstants.backgroundLight,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstants.backgroundLight,
          surfaceTintColor: ColorConstants.backgroundLight,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: ColorConstants.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            error: ColorConstants.red,
            surface: ColorConstants.lightGrey,
            primary: ColorConstants.primary),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorConstants.lightGrey,
          hintStyle: TextStyle(
            color: ColorConstants.grey,
          ),
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: ColorConstants.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: ColorConstants.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      );
}
