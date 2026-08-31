import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppRadius {
  AppRadius._();

  static const card = 16.0;
  static const input = 12.0;
  static const pill = 999.0;
}

class AppSpacing {
  AppSpacing._();

  static const sidebarWidth = 260.0;
  static const topbarHeight = 68.0;
  static const pagePadding = 32.0;
}

class AppTokens extends ThemeExtension<AppTokens> {
  final Color bg;
  final Color surface;
  final Color surfaceRaised;
  final Color text;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color inputBg;
  final Color inputBorder;
  final Color sidebarBg;
  final Color sidebarBorder;
  final Color topbarBg;
  final Color tableHeaderBg;
  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadowMd;
  final List<Color>? dashboardGradient;

  const AppTokens({
    required this.bg,
    required this.surface,
    required this.surfaceRaised,
    required this.text,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.inputBg,
    required this.inputBorder,
    required this.sidebarBg,
    required this.sidebarBorder,
    required this.topbarBg,
    required this.tableHeaderBg,
    required this.shadowSm,
    required this.shadowMd,
    this.dashboardGradient,
  });

  static final light = AppTokens(
    bg: AppColors.bgLight,
    surface: AppColors.surfaceLight,
    surfaceRaised: AppColors.surfaceRaisedLight,
    text: AppColors.textLight,
    textSecondary: AppColors.textSecondaryLight,
    textMuted: AppColors.textMutedLight,
    border: AppColors.borderLight,
    inputBg: AppColors.inputBgLight,
    inputBorder: AppColors.inputBorderLight,
    sidebarBg: AppColors.surfaceLight,
    sidebarBorder: AppColors.borderLight,
    topbarBg: AppColors.surfaceLight.withValues(alpha: 0.85),
    tableHeaderBg: AppColors.surfaceRaisedLight,
    shadowSm: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
    shadowMd: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static final dark = AppTokens(
    bg: AppColors.bgDark,
    surface: AppColors.surfaceDark,
    surfaceRaised: AppColors.surfaceRaisedDark,
    text: AppColors.textDark,
    textSecondary: AppColors.textSecondaryDark,
    textMuted: AppColors.textMutedDark,
    border: AppColors.borderDark,
    inputBg: AppColors.inputBgDark,
    inputBorder: AppColors.borderDark,
    sidebarBg: AppColors.surfaceDark,
    sidebarBorder: AppColors.borderDark,
    topbarBg: AppColors.surfaceDark.withValues(alpha: 0.85),
    tableHeaderBg: AppColors.surfaceRaisedDark,
    shadowSm: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.24),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
    shadowMd: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.32),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
    dashboardGradient: AppColors.dashboardGradientDark,
  );

  @override
  AppTokens copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceRaised,
    Color? text,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? inputBg,
    Color? inputBorder,
    Color? sidebarBg,
    Color? sidebarBorder,
    Color? topbarBg,
    Color? tableHeaderBg,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowMd,
    List<Color>? dashboardGradient,
  }) {
    return AppTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      inputBg: inputBg ?? this.inputBg,
      inputBorder: inputBorder ?? this.inputBorder,
      sidebarBg: sidebarBg ?? this.sidebarBg,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      topbarBg: topbarBg ?? this.topbarBg,
      tableHeaderBg: tableHeaderBg ?? this.tableHeaderBg,
      shadowSm: shadowSm ?? this.shadowSm,
      shadowMd: shadowMd ?? this.shadowMd,
      dashboardGradient: dashboardGradient ?? this.dashboardGradient,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      sidebarBg: Color.lerp(sidebarBg, other.sidebarBg, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      topbarBg: Color.lerp(topbarBg, other.topbarBg, t)!,
      tableHeaderBg: Color.lerp(tableHeaderBg, other.tableHeaderBg, t)!,
      shadowSm: t < 0.5 ? shadowSm : other.shadowSm,
      shadowMd: t < 0.5 ? shadowMd : other.shadowMd,
      dashboardGradient: t < 0.5 ? dashboardGradient : other.dashboardGradient,
    );
  }
}

extension AppTokensX on BuildContext {
  AppTokens get tokens =>
      Theme.of(this).extension<AppTokens>() ?? AppTokens.light;
}
