import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Filtre sonucu boşsa gösterilen durum widget'ı.
/// Neden: boş ekran hissi yerine yönlendirici geri bildirim verilsin.
class TodoEmptyState extends StatelessWidget {
  const TodoEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.task_alt_outlined,
        size: AppSize.v64,
        color: context.onSurfaceColor.withValues(alpha: 0.3),
      ),
      AppSize.v12.h,
      AppStrings.todoEmptyTitle.text.titleMedium(context).center,
      AppSize.v8.h,
      AppStrings.todoEmptySubTitle.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.55))
          .center,
    ].column(mainAxisAlignment: .center).paddingAll(AppSize.v24);
  }
}
