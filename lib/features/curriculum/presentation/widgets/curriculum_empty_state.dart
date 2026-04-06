import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Seçili sınıf + dönem kombinasyonunda müfredat bulunamadığında gösterilir.
class CurriculumEmptyState extends StatelessWidget {
  const CurriculumEmptyState({
    super.key,
    required this.classLevel,
    required this.semester,
    required this.onResetFilters,
  });

  final int? classLevel;
  final int? semester;
  final VoidCallback onResetFilters;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.menu_book_outlined,
        size: AppSize.v64,
        color: context.onSurfaceColor.withValues(alpha: 0.35),
      ),
      AppSize.v16.h,
      AppStrings.curriculumNotFound.text.titleMedium(context).center,
      AppSize.v8.h,
      AppStrings.curriculumNotFoundSub(
            classLevel: classLevel,
            semester: semester,
          ).text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.55))
          .center,
      AppSize.v20.h,
      OutlinedButton.icon(
        onPressed: onResetFilters,
        icon: const Icon(Icons.refresh),
        label: AppStrings.curriculumResetFilters.text,
      ),
    ].column(mainAxisAlignment: .center).paddingAll(AppSize.v24);
  }
}
