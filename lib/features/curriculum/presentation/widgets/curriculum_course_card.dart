import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Müfredat içindeki tek bir ders satırını kart görünümünde sunar.
class CurriculumCourseCard extends StatelessWidget {
  const CurriculumCourseCard({super.key, required this.curriculum});

  final CurriculumModel curriculum;

  @override
  Widget build(BuildContext context) {
    final courseTypeLabel = curriculum.isCompulsory
        ? AppStrings.curriculumCompulsory
        : AppStrings.curriculumElective;
    final typeColor = curriculum.isCompulsory
        ? AppColors.primary
        : AppColors.secondary;

    return [
          [
            [
              Icon(
                Icons.menu_book_outlined,
                color: context.primaryColor,
                size: AppSize.v16,
              ),
              curriculum.courseCode.text.labelLarge(context).semiBold,
            ].row(spacing: AppSize.v6),
            courseTypeLabel.text
                .labelSmall(context)
                .semiBold
                .color(typeColor)
                .paddingSymmetric(h: AppSize.v8, v: AppSize.v4)
                .container(
                  color: typeColor.withValues(alpha: 0.12),
                  borderRadius: AppSize.v8,
                  border: Border.all(color: typeColor.withValues(alpha: 0.25)),
                ),
          ].row(mainAxisAlignment: .spaceBetween),
          AppSize.v10.h,
          curriculum.courseName.text.titleMedium(context),
          AppSize.v12.h,
          [
            [
              Icon(
                Icons.workspace_premium_outlined,
                size: AppSize.v14,
                color: context.onSurfaceColor.withValues(alpha: 0.7),
              ),
              '${AppStrings.curriculumCredit}: ${curriculum.credit}'.text
                  .bodySmall(context)
                  .color(context.onSurfaceColor.withValues(alpha: 0.75)),
            ].row(spacing: AppSize.v4),
            [
              Icon(
                Icons.bar_chart_outlined,
                size: AppSize.v14,
                color: context.onSurfaceColor.withValues(alpha: 0.7),
              ),
              '${AppStrings.curriculumAkts}: ${curriculum.akts}'.text
                  .bodySmall(context)
                  .color(context.onSurfaceColor.withValues(alpha: 0.75)),
            ].row(spacing: AppSize.v4),
          ].row(spacing: AppSize.v16),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v16,
          border: Border.all(color: AppColors.border),
        );
  }
}
