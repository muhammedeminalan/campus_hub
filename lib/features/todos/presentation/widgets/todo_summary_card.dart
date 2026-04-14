import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Yapılacaklar ekranı üst özet kartı.
/// Neden: toplam/bekleyen/tamamlanan/geciken metrikleri tek bakışta verilsin.
class TodoSummaryCard extends StatelessWidget {
  const TodoSummaryCard({super.key, required this.todos});

  final List<TodoItem> todos;

  int get _total => todos.length;

  int get _completed => todos.where((todo) => todo.isCompleted).length;

  int get _pending => todos.where((todo) => !todo.isCompleted).length;

  int get _overdue {
    final today = DateUtils.dateOnly(DateTime.now());
    return todos
        .where(
          (todo) =>
              !todo.isCompleted &&
              todo.dueDate != null &&
              DateUtils.dateOnly(todo.dueDate!).isBefore(today),
        )
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return [
          AppStrings.todoSummaryTitle.text
              .titleMedium(context)
              .semiBold
              .color(context.onPrimaryColor),
          AppSize.v12.h,
          [
            _MetricItem(label: AppStrings.todoTotal, value: '$_total'),
            _MetricItem(label: AppStrings.todoPending, value: '$_pending'),
            _MetricItem(label: AppStrings.todoCompleted, value: '$_completed'),
            _MetricItem(label: AppStrings.todoOverdue, value: '$_overdue'),
          ].row(mainAxisAlignment: .spaceBetween),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v16)
        .container(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSize.v16,
        );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return [
      value.text.titleLarge(context).semiBold.color(context.onPrimaryColor),
      AppSize.v2.h,
      label.text
          .labelSmall(context)
          .color(context.onPrimaryColor.withValues(alpha: 0.78)),
    ].column();
  }
}
