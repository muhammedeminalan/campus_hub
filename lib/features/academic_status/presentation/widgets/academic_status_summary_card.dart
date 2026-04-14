import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/usecases/calculate_academic_status_summary_use_case.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Akademik durum ekranı üst özet kartı.
/// Neden: öğrencinin kritik metrikleri tek bakışta okuyabilmesi.
class AcademicStatusSummaryCard extends StatelessWidget {
  const AcademicStatusSummaryCard({
    super.key,
    required this.status,
    required this.summary,
  });

  final AcademicStatusModel status;
  final AcademicStatusSummary summary;

  @override
  Widget build(BuildContext context) {
    final standing = _resolveStanding();

    return Stack(
      children: [
        [
              _buildHeader(context, standing),
              AppSize.v12.h,
              _buildInfo(context),
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
                color: context.onPrimaryColor.withValues(alpha: 0.14),
              ),
            ),
        Positioned(
          top: -AppSize.v24,
          right: -AppSize.v20,
          child: Container(
            width: AppSize.v96,
            height: AppSize.v96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.onPrimaryColor.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: -AppSize.v24,
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

  Widget _buildHeader(BuildContext context, _StandingInfo standing) {
    return [
      [
        Icon(Icons.workspace_premium_rounded, color: context.onPrimaryColor),
        AppSize.v8.w,
        Text(
          AppStrings.academicStatusSummaryTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.onPrimaryColor,
          ),
        ).expanded(),
      ].row().expanded(),
      standing.label.text
          .labelSmall(context)
          .semiBold
          .color(standing.color)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(color: context.onPrimaryColor, borderRadius: AppSize.v20),
    ].row(crossAxisAlignment: .center);
  }

  Widget _buildInfo(BuildContext context) {
    return [
      '${AppStrings.academicStatusClassLabel}: ${status.classLevel}'.text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.academicStatusAdvisorLabel}: ${status.advisor}'.text
          .bodySmall(context)
          .maxLine(1)
          .ellipsis
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
      AppSize.v4.h,
      '${AppStrings.academicStatusTargetCredit}: ${status.targetGraduationCredit}'
          .text
          .bodySmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.9)),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildMetrics(BuildContext context) {
    return [
      _MetricItem(
        label: AppStrings.agno,
        value: summary.gano.toStringAsFixed(2),
      ).expanded(),
      AppSize.v10.w,
      _MetricItem(
        label: AppStrings.academicStatusCompletedCredit,
        value: '${summary.completedCredits}',
      ).expanded(),
      AppSize.v10.w,
      _MetricItem(
        label: AppStrings.academicStatusRemainingCredit,
        value: '${summary.remainingCredits}',
      ).expanded(),
    ].row();
  }

  Widget _buildProgress(BuildContext context) {
    return [
      '${AppStrings.academicStatusSuccessRate}: ${summary.successRatePercent}%'
          .text
          .labelSmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.88)),
      AppSize.v6.h,
      LinearProgressIndicator(
        value: summary.successRatePercent / 100,
        minHeight: AppSize.v8,
        borderRadius: BorderRadius.circular(AppSize.v20),
        backgroundColor: context.onPrimaryColor.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(
          context.onPrimaryColor.withValues(alpha: 0.95),
        ),
      ),
      AppSize.v8.h,
      [
        '${AppStrings.academicStatusPassedCourses}: ${summary.passedCourses}'
            .text
            .labelSmall(context)
            .color(context.onPrimaryColor.withValues(alpha: 0.9))
            .expanded(),
        '${AppStrings.academicStatusFailedCourses}: ${summary.failedCourses}'
            .text
            .labelSmall(context)
            .color(context.onPrimaryColor.withValues(alpha: 0.9))
            .expanded(),
        '${AppStrings.academicStatusRiskyCourses}: ${summary.riskyCourses}'.text
            .labelSmall(context)
            .color(context.onPrimaryColor.withValues(alpha: 0.9))
            .expanded(),
      ].row(),
    ].column(crossAxisAlignment: .start);
  }

  _StandingInfo _resolveStanding() {
    if (summary.gano < 2) {
      return const _StandingInfo(
        label: AppStrings.academicStatusStandingProbation,
        color: AppColors.error,
      );
    }

    if (summary.failedCourses > 0 || summary.riskyCourses > 0) {
      return const _StandingInfo(
        label: AppStrings.academicStatusStandingWarning,
        color: AppColors.warning,
      );
    }

    return const _StandingInfo(
      label: AppStrings.academicStatusStandingGood,
      color: AppColors.success,
    );
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
              .color(context.onPrimaryColor)
              .maxLine(1),
          AppSize.v2.h,
          label.text
              .labelSmall(context)
              .maxLine(2)
              .color(context.onPrimaryColor.withValues(alpha: 0.8)),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v10)
        .container(
          color: context.onPrimaryColor.withValues(alpha: 0.1),
          borderRadius: AppSize.v12,
          border: Border.all(
            color: context.onPrimaryColor.withValues(alpha: 0.1),
          ),
        );
  }
}

class _StandingInfo {
  const _StandingInfo({required this.label, required this.color});

  final String label;
  final Color color;
}
