import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hazırlık ekranı üst özet kartı.
/// Neden: öğrencinin genel durumunu tek karttan okunabilir kılmak.
class PreparatorySummaryCard extends StatelessWidget {
  const PreparatorySummaryCard({
    super.key,
    required this.info,
    required this.summary,
  });

  final PreparatoryInfoModel info;
  final PreparatoryProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        [
              _buildHeader(context),
              AppSize.v12.h,
              _buildTopInfo(context),
              AppSize.v14.h,
              _buildMetrics(context),
              AppSize.v12.h,
              _buildProgress(context),
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
              border: Border.all(
                color: context.onPrimaryColor.withValues(alpha: 0.16),
              ),
            ),
        Positioned(
          top: -AppSize.v24,
          right: -AppSize.v28,
          child: Container(
            width: AppSize.v96,
            height: AppSize.v96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.onPrimaryColor.withValues(alpha: 0.09),
            ),
          ),
        ),
        Positioned(
          bottom: -AppSize.v28,
          left: -AppSize.v24,
          child: Container(
            width: AppSize.v80,
            height: AppSize.v80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.onPrimaryColor.withValues(alpha: 0.06),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return [
      [
        Icon(Icons.auto_awesome_rounded, color: context.onPrimaryColor),
        AppSize.v8.w,
        Text(
          AppStrings.preparatorySummaryTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.onPrimaryColor,
          ),
        ).expanded(),
      ].row().expanded(),
      '${AppStrings.preparatoryLevel} ${info.level}'.text
          .labelMedium(context)
          .semiBold
          .color(context.primaryColor)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(color: context.onPrimaryColor, borderRadius: AppSize.v20),
    ].row(crossAxisAlignment: .center);
  }

  Widget _buildTopInfo(BuildContext context) {
    return [
      '${AppStrings.preparatoryClass}: ${info.currentClass}'.text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.preparatoryAdvisor}: ${info.advisor}'.text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.preparatoryExemptionStatus}: ${info.exemptionStatus}'.text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.preparatoryAbsence}: ${info.remainingAbsence}/${info.maxAbsence}'
          .text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildMetrics(BuildContext context) {
    return [
      _MetricItem(
        label: AppStrings.preparatoryCompletedModules,
        value: '${summary.completedModules}/${summary.totalModules}',
      ).expanded(),
      AppSize.v10.w,
      _MetricItem(
        label: AppStrings.preparatoryPassedExams,
        value: '${summary.passedExams}/${summary.totalExams}',
      ).expanded(),
    ].row();
  }

  Widget _buildProgress(BuildContext context) {
    return [
      AppStrings.preparatoryProgressLabel.text
          .labelSmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.85)),
      AppSize.v6.h,
      LinearProgressIndicator(
        value: summary.moduleCompletionPercent / 100,
        minHeight: AppSize.v8,
        borderRadius: BorderRadius.circular(AppSize.v20),
        backgroundColor: context.onPrimaryColor.withValues(alpha: 0.18),
        valueColor: AlwaysStoppedAnimation<Color>(
          context.onPrimaryColor.withValues(alpha: 0.95),
        ),
      ),
      AppSize.v6.h,
      '${summary.moduleCompletionPercent}%'.text
          .labelMedium(context)
          .semiBold
          .color(context.onPrimaryColor),
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
          value.text
              .titleMedium(context)
              .semiBold
              .color(context.onPrimaryColor),
          AppSize.v2.h,
          label.text
              .labelSmall(context)
              .color(context.onPrimaryColor.withValues(alpha: 0.78))
              .maxLine(2),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v10)
        .container(
          color: context.onPrimaryColor.withValues(alpha: 0.1),
          borderRadius: AppSize.v12,
          border: Border.all(
            color: context.onPrimaryColor.withValues(alpha: 0.12),
          ),
        );
  }
}
