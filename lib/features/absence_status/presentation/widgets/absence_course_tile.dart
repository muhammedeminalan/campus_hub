import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Ders bazlı devamsızlık kartı.
/// Neden: kullanıcı her ders için kullanılan/izinli/kalan saatleri açık görsün.
class AbsenceCourseTile extends StatelessWidget {
  const AbsenceCourseTile({super.key, required this.course});

  final AbsenceCourseModel course;

  @override
  Widget build(BuildContext context) {
    final status = _resolveStatus();

    return [
          _buildHeader(context, status),
          AppSize.v10.h,
          _buildStats(context),
          AppSize.v10.h,
          LinearProgressIndicator(
            value: course.usedRatio,
            minHeight: AppSize.v8,
            borderRadius: BorderRadius.circular(AppSize.v20),
            color: status.color,
            backgroundColor: status.color.withValues(alpha: 0.15),
          ),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v14)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v14,
          border: Border.all(color: status.color.withValues(alpha: 0.25)),
        );
  }

  Widget _buildHeader(BuildContext context, _StatusInfo status) {
    return [
      course.courseTitle.text.titleSmall(context).semiBold.expanded(),
      status.label.text
          .labelSmall(context)
          .semiBold
          .color(status.color)
          .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
          .container(
            color: status.color.withValues(alpha: 0.12),
            borderRadius: AppSize.v20,
          ),
    ].row();
  }

  Widget _buildStats(BuildContext context) {
    return [
      _ValuePill(
        icon: Icons.schedule,
        label: AppStrings.absenceCourseTotal,
        value: '${course.totalCourseHours} ${AppStrings.absenceHour}',
        color: AppColors.info,
      ),
      _ValuePill(
        icon: Icons.remove_circle_outline,
        label: AppStrings.absenceCourseUsed,
        value: '${course.absentHours} ${AppStrings.absenceHour}',
        color: AppColors.warning,
      ),
      _ValuePill(
        icon: Icons.verified_outlined,
        label: AppStrings.absenceCourseAllowed,
        value: '${course.maxAllowedAbsenceHours} ${AppStrings.absenceHour}',
        color: AppColors.success,
      ),
      _ValuePill(
        icon: Icons.hourglass_bottom,
        label: AppStrings.absenceCourseRemaining,
        value: '${course.remainingAbsenceHours} ${AppStrings.absenceHour}',
        color: _resolveStatus().color,
      ),
    ].column(spacing: AppSize.v8);
  }

  _StatusInfo _resolveStatus() {
    if (course.isExceeded) {
      return const _StatusInfo(
        label: AppStrings.absenceStatusExceeded,
        color: AppColors.error,
      );
    }
    if (course.isRisky) {
      return const _StatusInfo(
        label: AppStrings.absenceStatusRisk,
        color: AppColors.warning,
      );
    }

    return const _StatusInfo(
      label: AppStrings.absenceStatusSafe,
      color: AppColors.success,
    );
  }
}

class _ValuePill extends StatelessWidget {
  const _ValuePill({
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
          Icon(icon, size: AppSize.v16, color: color),
          AppSize.v8.w,
          label.text
              .labelSmall(context)
              .color(context.onSurfaceColor.withValues(alpha: 0.7))
              .expanded(),
          value.text.labelSmall(context).semiBold.color(color),
        ]
        .row()
        .paddingSymmetric(h: AppSize.v10, v: AppSize.v8)
        .container(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppSize.v10,
        );
  }
}

class _StatusInfo {
  const _StatusInfo({required this.label, required this.color});

  final String label;
  final Color color;
}
