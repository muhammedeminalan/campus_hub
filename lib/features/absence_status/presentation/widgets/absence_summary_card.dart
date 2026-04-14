import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/absence_status/domain/usecases/calculate_absence_summary_use_case.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Devamsızlık ekranı üst özet kartı.
/// Neden: kritik metrikleri tek alanda hızlı okunur yapmak.
class AbsenceSummaryCard extends StatelessWidget {
  const AbsenceSummaryCard({super.key, required this.summary});

  final AbsenceSummary summary;

  @override
  Widget build(BuildContext context) {
    return [
          [
            Icon(Icons.timeline_rounded, color: context.onPrimaryColor),
            AppSize.v8.w,
            AppStrings.absenceSummaryTitle.text
                .titleMedium(context)
                .semiBold
                .color(context.onPrimaryColor),
          ].row(),
          AppSize.v12.h,
          _buildMetrics(context),
          AppSize.v12.h,
          _buildAlerts(context),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSize.v16,
        );
  }

  Widget _buildMetrics(BuildContext context) {
    return [
      _MetricItem(
        label: AppStrings.absenceTotalHours,
        value: '${summary.totalCourseHours}',
      ).expanded(),
      AppSize.v8.w,
      _MetricItem(
        label: AppStrings.absenceUsedHours,
        value: '${summary.totalAbsentHours}',
      ).expanded(),
      AppSize.v8.w,
      _MetricItem(
        label: AppStrings.absenceRemainingHours,
        value: '${summary.totalRemainingHours}',
      ).expanded(),
    ].row();
  }

  Widget _buildAlerts(BuildContext context) {
    return [
      '${AppStrings.absenceRiskyCourseCount}: ${summary.riskyCourseCount}'.text
          .labelSmall(context)
          .semiBold
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.absenceExceededCourseCount}: ${summary.exceededCourseCount}'
          .text
          .labelSmall(context)
          .semiBold
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
    ].column(crossAxisAlignment: .start);
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return [
          value.text.titleLarge(context).semiBold.color(context.onPrimaryColor),
          AppSize.v2.h,
          label.text
              .labelSmall(context)
              .maxLine(2)
              .color(context.onPrimaryColor.withValues(alpha: 0.8)),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v8)
        .container(
          color: context.onPrimaryColor.withValues(alpha: 0.1),
          borderRadius: AppSize.v10,
        );
  }
}
