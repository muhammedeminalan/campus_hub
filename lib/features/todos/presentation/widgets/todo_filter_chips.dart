import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/todos/domain/usecases/filter_todos_use_case.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Görev filtresi seçim alanı.
/// Neden: filtre davranışı tek widget'ta toplanıp view sade kalsın.
class TodoFilterChips extends StatelessWidget {
  const TodoFilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TodoFilter selected;
  final ValueChanged<TodoFilter> onChanged;

  static const _filters = [
    TodoFilter.all,
    TodoFilter.pending,
    TodoFilter.completed,
    TodoFilter.overdue,
  ];

  @override
  Widget build(BuildContext context) {
    return [
      AppStrings.todoFilterTitle.text.labelLarge(context).semiBold,
      AppSize.v8.h,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters
              .map(
                (filter) => Padding(
                  padding: const EdgeInsets.only(right: AppSize.v8),
                  child: ChoiceChip(
                    label: _labelFor(filter).text,
                    selected: selected == filter,
                    onSelected: (_) => onChanged(filter),
                    showCheckmark: false,
                    selectedColor: context.primaryColor.withValues(alpha: 0.14),
                    side: BorderSide(
                      color: selected == filter
                          ? context.primaryColor
                          : context.outlineColor.withValues(alpha: 0.45),
                    ),
                    labelStyle: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selected == filter
                          ? context.primaryColor
                          : context.onSurfaceColor.withValues(alpha: 0.75),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ].column(crossAxisAlignment: .start);
  }

  String _labelFor(TodoFilter filter) {
    return switch (filter) {
      TodoFilter.all => AppStrings.todoFilterAll,
      TodoFilter.pending => AppStrings.todoFilterPending,
      TodoFilter.completed => AppStrings.todoFilterCompleted,
      TodoFilter.overdue => AppStrings.todoFilterOverdue,
    };
  }
}
