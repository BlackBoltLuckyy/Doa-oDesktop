import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _build(AppTokens.light, Brightness.light);

  static ThemeData get darkTheme => _build(AppTokens.dark, Brightness.dark);

  static ThemeData _build(AppTokens tokens, Brightness brightness) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: tokens.bg,
      primaryColor: AppColors.primary,
      colorScheme: base.colorScheme.copyWith(
        brightness: brightness,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: tokens.surface,
        error: AppColors.statusRejected,
      ),
      extensions: [tokens],
      textTheme: base.textTheme.apply(
        bodyColor: tokens.text,
        displayColor: tokens.text,
      ),
      dividerTheme: DividerThemeData(color: tokens.border, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.inputBg,
        hintStyle: AppTextStyles.body.copyWith(color: tokens.textMuted),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: tokens.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: tokens.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.statusRejected),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tokens.text,
          side: BorderSide(color: tokens.border),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
          ),
          textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: tokens.textSecondary),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: tokens.text,
        contentTextStyle: AppTextStyles.body.copyWith(color: tokens.surface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: tokens.text,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.label.copyWith(color: tokens.surface),
      ),
    );
  }
}
