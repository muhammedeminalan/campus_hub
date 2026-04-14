import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Akademik durum ders kartı.
/// Neden: her dersin başarı/risk bilgisini tek satır akışta okunur kılmak.
class AcademicStatusCourseTile extends StatelessWidget {
  const AcademicStatusCourseTile({super.key, required this.course});

  final AcademicCourseModel course;

  @override
  Widget build(BuildContext context) {
    final status = _resolveStatus();

    return [
          _buildHeader(context, status),
          AppSize.v10.h,
          _buildMeta(context),
          AppSize.v10.h,
          _buildMetricRow(context),
          AppSize.v10.h,
          LinearProgressIndicator(
            value: course.scoreRatio,
            minHeight: AppSize.v8,
            borderRadius: BorderRadius.circular(AppSize.v20),
            color: status.color,
            backgroundColor: status.color.withValues(alpha: 0.18),
          ),
          AppSize.v8.h,
          [
            status.label.text
                .labelSmall(context)
                .semiBold
                .color(status.color)
                .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
                .container(
                  color: status.color.withValues(alpha: 0.12),
                  borderRadius: AppSize.v20,
                ),
            AppSize.v8.w,
            '${AppStrings.academicStatusCourseAverage}: ${course.averageScore}'
                .text
                .labelSmall(context)
                .semiBold
                .color(context.onSurfaceColor.withValues(alpha: 0.72))
                .expanded(),
          ].row(),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v14)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v14,
          border: Border.all(color: status.color.withValues(alpha: 0.25)),
        );
  }

  Widget _buildHeader(BuildContext context, _CourseStatusInfo status) {
    return [
      course.courseTitle.text
          .titleSmall(context)
          .semiBold
          .maxLine(1)
          .expanded(),
      AppSize.v8.w,
      course.letterGrade.text
          .labelMedium(context)
          .semiBold
          .color(status.color)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(
            color: status.color.withValues(alpha: 0.12),
            borderRadius: AppSize.v20,
          ),
    ].row(crossAxisAlignment: .center);
  }

  Widget _buildMeta(BuildContext context) {
    return [
      [
        Icon(
          Icons.event_note_outlined,
          size: AppSize.v16,
          color: context.onSurfaceColor.withValues(alpha: 0.7),
        ),
        AppSize.v6.w,
        course.termLabel.text
            .labelSmall(context)
            .color(context.onSurfaceColor.withValues(alpha: 0.75))
            .maxLine(1)
            .expanded(),
      ].row().expanded(),
      AppSize.v10.w,
      '${course.credit} ${AppStrings.academicStatusCreditUnit}'.text
          .labelSmall(context)
          .semiBold
          .color(AppColors.info)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: AppSize.v20,
          ),
    ].row();
  }

  Widget _buildMetricRow(BuildContext context) {
    return [
      _ValueItem(
        icon: Icons.speed_rounded,
        label: AppStrings.academicStatusCoursePoint,
        value: course.gradePoint.toStringAsFixed(1),
        color: AppColors.primary,
      ).expanded(),
      AppSize.v8.w,
      _ValueItem(
        icon: Icons.show_chart_rounded,
        label: AppStrings.academicStatusCourseWeightedPoint,
        value: course.weightedPoint.toStringAsFixed(1),
        color: AppColors.secondaryDark,
      ).expanded(),
    ].row();
  }

  _CourseStatusInfo _resolveStatus() {
    if (course.isFailed) {
      return const _CourseStatusInfo(
        label: AppStrings.academicStatusCourseFailed,
        color: AppColors.error,
      );
    }

    if (course.isRisky) {
      return const _CourseStatusInfo(
        label: AppStrings.academicStatusCourseRisk,
        color: AppColors.warning,
      );
    }

    return const _CourseStatusInfo(
      label: AppStrings.academicStatusCoursePassed,
      color: AppColors.success,
    );
  }
}

class _ValueItem extends StatelessWidget {
  const _ValueItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return [
          [
            Icon(icon, size: AppSize.v16, color: color),
            AppSize.v6.w,
            label.text
                .labelSmall(context)
                .color(context.onSurfaceColor.withValues(alpha: 0.72))
                .maxLine(1)
                .expanded(),
          ].row(),
          AppSize.v6.h,
          value.text.labelLarge(context).semiBold.color(color).maxLine(1),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v10)
        .container(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppSize.v10,
        );
  }
}

class _CourseStatusInfo {
  const _CourseStatusInfo({required this.label, required this.color});

  final String label;
  final Color color;
}
