import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hazırlık modül satırı.
/// Neden: modül ilerleme bilgisi liste içinde standart görünsün.
class PreparatoryModuleTile extends StatelessWidget {
  const PreparatoryModuleTile({super.key, required this.module});

  final PreparatoryModuleModel module;

  @override
  Widget build(BuildContext context) {
    final statusColor = module.isCompleted
        ? AppColors.success
        : AppColors.warning;

    return [
          Icon(
            module.isCompleted
                ? Icons.check_circle_rounded
                : Icons.pending_actions_rounded,
            color: statusColor,
          ),
          AppSize.v12.w,
          [
            module.title.text.titleSmall(context).semiBold,
            AppSize.v4.h,
            '${AppStrings.preparatoryModuleAttendance}: %${module.attendanceRate}'
                .text
                .bodySmall(context)
                .color(context.onSurfaceColor.withValues(alpha: 0.72)),
            AppSize.v2.h,
            module.instructor.text
                .bodySmall(context)
                .color(context.onSurfaceColor.withValues(alpha: 0.65)),
          ].column(crossAxisAlignment: .start).expanded(),
          (module.isCompleted
                  ? AppStrings.preparatoryModuleCompleted
                  : AppStrings.preparatoryModuleInProgress)
              .text
              .labelSmall(context)
              .semiBold
              .color(statusColor),
        ]
        .row(crossAxisAlignment: .center)
        .paddingAll(AppSize.v14)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v14,
          border: Border.all(color: statusColor.withValues(alpha: 0.25)),
        );
  }
}
