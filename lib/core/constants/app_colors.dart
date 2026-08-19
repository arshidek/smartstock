import 'package:flutter/material.dart';

class AppColors {
  // Background Colors
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFBFD8FF), Color(0xFFFFFFFF), Color(0xFFBFD8FF)],
    stops: [0.0, 0.5, 1.0],
  );

  static const Color appBarColor = Color(0xFFBFD8FF);

  // colors
  static Color white = Colors.white;
  static const Color white70 = Colors.white70;

  static const Color lightWhite = Color(0xFFCADDF1);
  static const Color purple = Color(0xFF8939DD);
  static const Color lightPurple = Color(0xFFE3CDFA);

  static const Color blue = Color(0xFF1248F6);
  static const Color lightBlue = Color(0xFFF2F4FB);
  static const Color textFieldBlue = Color(0xFF6A8AF1);
  static const Color black = Color(0xFF00040B);
  static const Color lightBlack = Color(0xFF474749);
  static const Color grey = Color(0xFF90949A);
  static const Color lightGrey = Color(0x73ACAAAA);
  static const Color success = Color(0xFF22C55E);
  static const Color lightGreen = Color(0xFFD1FBE1);
  static const Color warning = Color(0xFFF59E0B);
  static const Color lightWarning = Color(0xFFF8EDDD);
  static const Color error = Color(0xFFF34141);
  static const Color lightRed = Color(0x89E6B5B5);

  //image background
  static Color logoBackground = Colors.white;

  // shadow
  static Color blueShadow = Colors.blue.withOpacity(0.20);
  static Color blackShadow = Colors.black.withOpacity(0.04);

  static Color glassIconBackground = Colors.blue.withOpacity(0.20);
  // Boarder Colors
  static Color glassBorder = Colors.white.withOpacity(0.3);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E2937);
  // Status Colors
  static const Color cyan = Color(0xFF06B6D4);
  static const Color lightCyan = Color(0xFFCFFAFE);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF1D4ED8);
  static const Color indigo = Color(0xFF4338CA);
  static const Color lightIndigo = Color(0xFFE0E7FF);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color emerald = Color(0xFF10B981);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textLight = Color(0xFF6B7280);
}
