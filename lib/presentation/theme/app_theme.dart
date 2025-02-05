import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: "EuclidCircular",
        useMaterial3: true,
        primaryColor: ColorConstants.primary,
        scaffoldBackgroundColor: ColorConstants.white,
        hintColor: ColorConstants.grey,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          error: ColorConstants.red,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorConstants.lightGrey,
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
