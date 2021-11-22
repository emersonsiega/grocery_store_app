import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          brightness: Brightness.light,
          background: AppColors.background,
          error: AppColors.error,
          surface: AppColors.background,
          onSurface: AppColors.text,
          onPrimary: AppColors.background,
          onBackground: AppColors.text,
          onSecondary: AppColors.background,
          primaryVariant: AppColors.primaryVariant,
          secondaryVariant: AppColors.secondary,
          onError: AppColors.background,
        ),
        primaryColor: AppColors.primary,
        backgroundColor: AppColors.background,
        canvasColor: AppColors.background,
        dividerColor: AppColors.disabled,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: GoogleFonts.inter(
            color: AppColors.disabled,
            fontSize: 16.fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        textTheme: GoogleFonts.interTextTheme().copyWith(
          headline5: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 24.fontSize,
            fontWeight: FontWeight.w500,
          ),
          headline6: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 20.fontSize,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 14.fontSize,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 12.fontSize,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 14.fontSize,
            fontWeight: FontWeight.w500,
          ),
          button: GoogleFonts.inter(
            color: AppColors.text,
            fontSize: 14.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        primaryTextTheme: GoogleFonts.dancingScriptTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const StadiumBorder()),
            minimumSize: MaterialStateProperty.all(Size(250.width, 46.height)),
          ),
        ),
      );
}

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
