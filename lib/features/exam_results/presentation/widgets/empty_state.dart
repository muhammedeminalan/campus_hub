import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.period});

  final String period;

  @override
  Widget build(BuildContext context) {
    return [
      Icon(Icons.assignment_outlined,
          size: AppSize.v64,
          color: context.onSurfaceColor.withValues(alpha: 0.3)),
      AppSize.v16.h,
      'Sınav Sonucu Bulunamadı'.text.titleMedium(context).center,
      AppSize.v8.h,
      '$period dönemine ait sınav\nkaydı mevcut değil.'.text
          .bodySmall(context)
          .color(context.onSurfaceColor.withValues(alpha: 0.5))
          .center,
    ].column(mainAxisAlignment: .center).center;
  }
}
