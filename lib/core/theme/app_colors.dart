import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Marca
  static const primary = Color(0xFF6C63FF);
  static const primaryDark = Color(0xFF5A52D5);
  static const secondary = Color(0xFFFF6584);
  static const accent = Color(0xFF43D9A2);
  static const warning = Color(0xFFFFD166);

  // Claro
  static const bgLight = Color(0xFFF8FAFC);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceRaisedLight = Color(0xFFF1F5F9);
  static const textLight = Color(0xFF1E293B);
  static const textSecondaryLight = Color(0xFF475569);
  static const textMutedLight = Color(0xFF64748B);
  static const borderLight = Color(0xFFE2E8F0);
  static const inputBorderLight = Color(0xFFD1D5DB);
  static const inputBgLight = Color(0xFFFFFFFF);

  // Escuro
  static const bgDark = Color(0xFF0F172A);
  static const surfaceDark = Color(0xFF1E293B);
  static const surfaceRaisedDark = Color(0xFF334155);
  static const textDark = Color(0xFFF1F5F9);
  static const textSecondaryDark = Color(0xFFCBD5E1);
  static const textMutedDark = Color(0xFF8892B0);
  static final borderDark = primary.withValues(alpha: 0.18);
  static final inputBgDark = Colors.white.withValues(alpha: 0.06);

  // Gradiente de fundo do dashboard no escuro (135°)
  static const dashboardGradientDark = [
    Color(0xFF0F0F1A),
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
  ];

  // Status
  static const statusPending = Color(0xFFFFD166);
  static const statusApproved = Color(0xFF43D9A2);
  static const statusRejected = Color(0xFFFF6584);
  static const statusInStock = Color(0xFF6C63FF);
  static const statusDelivered = Color(0xFF8B5CF6);
  static const statusNeutral = Color(0xFF64748B);

  // Paleta categórica para gráficos
  static const chartPalette = [
    primary,
    accent,
    secondary,
    warning,
    Color(0xFF8B5CF6),
    statusNeutral,
  ];
}
