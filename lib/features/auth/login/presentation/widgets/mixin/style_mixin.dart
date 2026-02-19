import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

import '../../../../../../core/constants/app_sizes.dart';

mixin StyleMixin<T extends StatefulWidget> on State<T> {
  // ── Sabitler ──

  double get shadowAlpha => 0.3;
  double get shadowAlphaTree => 0.3;
  Offset get shadowOffset => const Offset(0, 2);
  double get labelFontSize => 15.0;
  IconData get studentIcon => Icons.school_outlined;
  IconData get teacherIcon => Icons.cast_for_education_outlined;

  // ── Indicator ──

  BoxDecoration get indicatorBoxDecoration => BoxDecoration(
    color: context.primaryColor,
    borderRadius: BorderRadius.circular(AppSize.v12),
    boxShadow: [
      BoxShadow(
        color: context.primaryColor.withValues(alpha: shadowAlpha),
        blurRadius: AppSize.v8,
        offset: shadowOffset,
      ),
    ],
  );

  // ── Label Styles ──

  TextStyle get labelStyle => context.theme.textTheme.bodyMedium!.copyWith(
    fontSize: labelFontSize,
    fontWeight: FontWeight.w600,
  );

  TextStyle get unselectedLabelStyle =>
      context.theme.textTheme.bodyMedium!.copyWith(fontSize: labelFontSize);

  // ── Tab Bar Container ──

  BorderRadius get tabBarBorderRadius => BorderRadius.circular(AppSize.v12);

  BoxDecoration get tabBarContainerDecoration => BoxDecoration(
    color: context.surfaceColor,
    borderRadius: BorderRadius.circular(AppSize.v16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: shadowAlphaTree),
        blurRadius: AppSize.v12,
        offset: shadowOffset,
      ),
    ],
  );

  EdgeInsets get tabBarContainerMargin =>
      const EdgeInsets.symmetric(horizontal: AppSize.v24);

  EdgeInsets get tabBarContainerPadding => const EdgeInsets.all(AppSize.v4);
}
