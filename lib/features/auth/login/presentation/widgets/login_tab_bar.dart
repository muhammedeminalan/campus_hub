import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

/// Login sayfasındaki Öğrenci / Öğretmen seçimi için modern segment TabBar.
class LoginTabBar extends StatelessWidget {
  const LoginTabBar({super.key, required this.controller});

  final TabController controller;

  // ── Sabitler ──
  static const _outerRadius = AppSize.v16;
  static const _innerRadius = AppSize.v12;
  static const _outerPadding = AppSize.v4;
  static const _horizontalMargin = AppSize.v24;
  static const _backgroundAlpha = 0.6;
  static const _shadowAlpha = 0.3;
  static const _shadowBlur = AppSize.v8;
  static const _shadowOffset = Offset(0, 2);
  static const _labelFontSize = 15.0;

  static const _studentIcon = Icons.school_outlined;
  static const _teacherIcon = Icons.cast_for_education_outlined;

  static const _selectedStyle = TextStyle(
    fontSize: _labelFontSize,
    fontWeight: FontWeight.w600,
  );
  static const _unselectedStyle = TextStyle(
    fontSize: _labelFontSize,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _horizontalMargin),
      padding: const EdgeInsets.all(_outerPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: _backgroundAlpha),
        borderRadius: BorderRadius.circular(_outerRadius),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(_innerRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _shadowAlpha),
              blurRadius: _shadowBlur,
              offset: _shadowOffset,
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primary,
        labelStyle: _selectedStyle,
        unselectedLabelStyle: _unselectedStyle,
        splashBorderRadius: BorderRadius.circular(_innerRadius),
        tabs: const [
          _LoginTab(icon: _studentIcon, label: AppStrings.student),
          _LoginTab(icon: _teacherIcon, label: AppStrings.teacher),
        ],
      ),
    );
  }
}

/// TabBar içindeki tek bir sekme.
class _LoginTab extends StatelessWidget {
  const _LoginTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  static const _iconSize = AppSize.v20;
  static const _gap = SizedBox(width: AppSize.v8);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: _iconSize),
          _gap,
          Text(label),
        ],
      ),
    );
  }
}
