import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get pageTitle => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      );

  static TextStyle get metricValue => GoogleFonts.inter(
        fontSize: 26,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get heading => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tableHeader => GoogleFonts.inter(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      );
}
