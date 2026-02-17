import 'package:flutter/material.dart';

/// CampusHub uygulama renk paleti.
/// Tüm renkler buradan okunur — hardcoded renk kullanılmaz.
abstract final class AppColors {
  // ── Primary (Mavi) ──
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ── Secondary ──
  static const Color secondary = Color(0xFF26C6DA);
  static const Color secondaryLight = Color(0xFF80DEEA);
  static const Color secondaryDark = Color(0xFF00838F);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // ── Background & Surface ──
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE8EAF0);
  static const Color onBackground = Color(0xFF1A1A2E);
  static const Color onSurface = Color(0xFF1A1A2E);

  // ── Scaffold ──
  static const Color scaffoldBackground = Color(0xFFF5F7FA);

  // ── Error ──
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color onError = Color(0xFFFFFFFF);

  // ── Success ──
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF66BB6A);

  // ── Warning ──
  static const Color warning = Color(0xFFF9A825);
  static const Color warningLight = Color(0xFFFDD835);

  // ── Info ──
  static const Color info = Color(0xFF1976D2);

  // ── Text ──
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ── Divider & Border ──
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFF1565C0);

  // ── Shadow ──
  static const Color shadow = Color(0x1A000000);

  // ── Shimmer ──
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}
