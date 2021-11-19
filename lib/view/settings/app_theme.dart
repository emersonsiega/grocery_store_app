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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textTheme: GoogleFonts.interTextTheme(),
        primaryTextTheme: GoogleFonts.dancingScriptTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const StadiumBorder()),
            minimumSize: MaterialStateProperty.all(Size(250.width, 46.height)),
          ),
        ),
      );
}
