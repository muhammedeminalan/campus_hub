import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Devamsızlık listesi boşsa gösterilecek durum.
/// Neden: kullanıcıya verinin neden görünmediğini açık anlatmak.
class AbsenceEmptyState extends StatelessWidget {
  const AbsenceEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.fact_check_outlined,
        size: AppSize.v64,
        color: context.onSurfaceColor.withValues(alpha: 0.3),
      ),
      AppSize.v12.h,
      AppStrings.absenceEmptyTitle.text.titleMedium(context).center,
      AppSize.v8.h,
      AppStrings.absenceEmptySubTitle.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.6))
          .center,
    ].column(mainAxisAlignment: .center).paddingAll(AppSize.v24);
  }
}
