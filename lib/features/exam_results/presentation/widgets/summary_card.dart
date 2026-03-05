import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.results});

  final List<ExamResultModel> results;

  // Benzersiz ders sayısı (Vize + Final ayrı sayılmaz).
  int get _courseCount => results.map((r) => r.courseTitle).toSet().length;

  // FF alan benzersiz ders sayısı.
  int get _failedCount => results
      .where((r) => r.letterGrade == 'FF')
      .map((r) => r.courseTitle)
      .toSet()
      .length;

  int get _passedCount => _courseCount - _failedCount;

  // Sadece girilmiş puanların (score >= 0) ortalaması.
  double get _average {
    final valid = results.where((r) => r.score >= 0).toList();
    if (valid.isEmpty) return 0;
    return valid.fold(0.0, (s, r) => s + r.score) / valid.length;
  }

  @override
  Widget build(BuildContext context) {
    return [
          [
            Icon(
              Icons.assessment_outlined,
              color: context.onPrimaryColor,
              size: AppSize.v20,
            ),
            AppStrings.summaryTitle.text.semiBold
                .fontSize(AppSize.v16)
                .color(context.onPrimaryColor),
          ].row(spacing: AppSize.v8).paddingOnly(bottom: AppSize.v16),
          [
            _StatItem(
              label: AppStrings.summaryCourseCount,
              value: '$_courseCount',
              icon: Icons.menu_book_outlined,
              color: context.onPrimaryColor,
            ),
            _SummaryDivider(),
            _StatItem(
              label: AppStrings.summaryPassed,
              value: '$_passedCount',
              icon: Icons.check_circle_outline,
              color: AppColors.successLight,
            ),
            _SummaryDivider(),
            _StatItem(
              label: AppStrings.summaryFailed,
              value: '$_failedCount',
              icon: Icons.cancel_outlined,
              color: AppColors.errorLight,
            ),
            _SummaryDivider(),
            _StatItem(
              label: AppStrings.summaryAvgScore,
              value: _average.toStringAsFixed(1),
              icon: Icons.bar_chart_rounded,
              color: AppColors.warningLight,
            ),
          ].row(mainAxisAlignment: .spaceAround),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v20)
        .container(
          gradient: LinearGradient(
            colors: [context.primaryColor, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSize.v16,
        );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: AppSize.v40,
    color: AppColors.onPrimary.withValues(alpha: 0.3),
  );
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(icon, color: color, size: AppSize.v20),
      value.text.bold.fontSize(AppSize.v18).color(color),
      label.text
          .fontSize(AppSize.v12)
          .color(AppColors.onPrimary.withValues(alpha: 0.75)),
    ].column(spacing: AppSize.v2);
  }
}
