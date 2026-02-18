import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// AppColors'a bağımlı BuildContext extension'ları.
/// Bu dosya ana projede kalır çünkü AppColors ana projenin config katmanına aittir.
extension ContextAppColorsExtension on BuildContext {
  // ── Semantic Renkler (AppColors) ──

  Color get successColor => AppColors.success;
  Color get successLightColor => AppColors.successLight;
  Color get warningColor => AppColors.warning;
  Color get warningLightColor => AppColors.warningLight;
  Color get infoColor => AppColors.info;
  Color get dividerColor => AppColors.divider;
  Color get borderColor => AppColors.border;
  Color get borderFocusedColor => AppColors.borderFocused;
  Color get shadowColor => AppColors.shadow;
  Color get shimmerBaseColor => AppColors.shimmerBase;
  Color get shimmerHighlightColor => AppColors.shimmerHighlight;

  // ── Text Renkleri ──

  Color get textPrimaryColor => AppColors.textPrimary;
  Color get textSecondaryColor => AppColors.textSecondary;
  Color get textHintColor => AppColors.textHint;
  Color get textDisabledColor => AppColors.textDisabled;
}
