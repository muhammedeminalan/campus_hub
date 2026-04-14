import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Hazırlık sınav satırı.
/// Neden: sınav sonucu bilgisi modül listesinden görsel olarak ayrılsın.
class PreparatoryExamTile extends StatelessWidget {
  const PreparatoryExamTile({super.key, required this.exam});

  final PreparatoryExamModel exam;

  @override
  Widget build(BuildContext context) {
    final statusColor = exam.isPassed ? AppColors.success : AppColors.error;

    return [
          Icon(
            exam.isPassed
                ? Icons.task_alt_rounded
                : Icons.warning_amber_rounded,
            color: statusColor,
          ),
          AppSize.v12.w,
          [
            exam.title.text.titleSmall(context).semiBold,
            AppSize.v4.h,
            exam.dateLabel.text
                .bodySmall(context)
                .color(context.onSurfaceColor.withValues(alpha: 0.72)),
          ].column(crossAxisAlignment: .start).expanded(),
          [
            '${exam.score}'.text
                .titleSmall(context)
                .semiBold
                .color(statusColor),
            AppSize.v2.h,
            (exam.isPassed
                    ? AppStrings.preparatoryExamPassed
                    : AppStrings.preparatoryExamFailed)
                .text
                .labelSmall(context)
                .semiBold
                .color(statusColor),
          ].column(crossAxisAlignment: .end),
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
