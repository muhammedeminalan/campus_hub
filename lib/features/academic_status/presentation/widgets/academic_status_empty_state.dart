import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Akademik durum listesi boşsa gösterilecek durum.
/// Neden: kullanıcıya verinin niye görünmediğini net anlatmak.
class AcademicStatusEmptyState extends StatelessWidget {
  const AcademicStatusEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.school_outlined,
        size: AppSize.v64,
        color: context.onSurfaceColor.withValues(alpha: 0.3),
      ),
      AppSize.v12.h,
      AppStrings.academicStatusEmptyTitle.text.titleMedium(context).center,
      AppSize.v8.h,
      AppStrings.academicStatusEmptySubTitle.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.6))
          .center,
    ].column(mainAxisAlignment: .center).paddingAll(AppSize.v24);
  }
}
