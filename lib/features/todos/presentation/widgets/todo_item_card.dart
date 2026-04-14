import 'package:campus_hub/config/theme/app_colors.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/todo_priority.dart';
import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Tek bir görevi kart olarak gösterir.
/// Neden: durum değiştirme etkileşimini liste item'ından ayrıştırmak.
class TodoItemCard extends StatelessWidget {
  const TodoItemCard({super.key, required this.todo, required this.onToggle});

  final TodoItem todo;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final priorityColor = _priorityColor(todo.priority);

    return [
          _buildHeader(context, priorityColor),
          AppSize.v8.h,
          _buildDescription(context),
          AppSize.v12.h,
          _buildFooter(context, priorityColor),
        ]
        .column(crossAxisAlignment: .start)
        .paddingAll(AppSize.v14)
        .container(
          color: context.surfaceColor,
          borderRadius: AppSize.v16,
          border: Border.all(
            color: todo.isCompleted
                ? AppColors.success.withValues(alpha: 0.25)
                : priorityColor.withValues(alpha: 0.25),
          ),
        );
  }

  Widget _buildHeader(BuildContext context, Color priorityColor) {
    final titleStyle = context.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
      color: todo.isCompleted
          ? context.onSurfaceColor.withValues(alpha: 0.45)
          : context.onSurfaceColor,
    );

    return [
      GestureDetector(
        onTap: onToggle,
        child: Icon(
          todo.isCompleted
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked,
          color: todo.isCompleted ? AppColors.success : priorityColor,
          size: AppSize.v24,
        ),
      ),
      AppSize.v10.w,
      Text(todo.title, style: titleStyle).expanded(),
    ].row(crossAxisAlignment: .start);
  }

  Widget _buildDescription(BuildContext context) {
    return todo.description.text
        .bodySmall(context)
        .color(context.onSurfaceColor.withValues(alpha: 0.72));
  }

  Widget _buildFooter(BuildContext context, Color priorityColor) {
    return [
      Wrap(
        spacing: AppSize.v8,
        runSpacing: AppSize.v8,
        children: [
          _InfoPill(
            icon: Icons.flag_outlined,
            label: _priorityLabel(todo.priority),
            color: priorityColor,
          ),
          _InfoPill(
            icon: Icons.schedule,
            label: _dueText(todo.dueDate),
            color: _dueColor(),
          ),
          _InfoPill(
            icon: Icons.label_outline,
            label: todo.category,
            color: context.primaryColor,
          ),
        ],
      ),
      AppSize.v8.h,
      TextButton.icon(
        onPressed: onToggle,
        icon: Icon(
          todo.isCompleted
              ? Icons.restart_alt_rounded
              : Icons.check_circle_outline,
        ),
        label:
            (todo.isCompleted
                    ? AppStrings.todoMarkAsPending
                    : AppStrings.todoMarkAsCompleted)
                .text,
      ).alignRight,
    ].column(crossAxisAlignment: .start);
  }

  String _priorityLabel(TodoPriority priority) {
    return switch (priority) {
      TodoPriority.low => AppStrings.todoPriorityLow,
      TodoPriority.medium => AppStrings.todoPriorityMedium,
      TodoPriority.high => AppStrings.todoPriorityHigh,
    };
  }

  Color _priorityColor(TodoPriority priority) {
    return switch (priority) {
      TodoPriority.low => AppColors.success,
      TodoPriority.medium => AppColors.warning,
      TodoPriority.high => AppColors.error,
    };
  }

  String _dueText(DateTime? dueDate) {
    if (dueDate == null) return AppStrings.todoNoDueDate;

    final today = DateUtils.dateOnly(DateTime.now());
    final due = DateUtils.dateOnly(dueDate);
    final dayDiff = due.difference(today).inDays;

    if (dayDiff == 0) return AppStrings.todoDueToday;
    if (dayDiff == 1) return AppStrings.todoDueTomorrow;
    if (dayDiff < 0) return AppStrings.todoOverdueByDays(dayDiff.abs());
    return AppStrings.todoDueInDays(dayDiff);
  }

  Color _dueColor() {
    if (todo.isCompleted) return AppColors.success;

    final dueDate = todo.dueDate;
    if (dueDate == null) return AppColors.info;

    final today = DateUtils.dateOnly(DateTime.now());
    final due = DateUtils.dateOnly(dueDate);

    if (due.isBefore(today)) return AppColors.error;
    if (due == today) return AppColors.warning;
    return AppColors.info;
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return [
          Icon(icon, size: AppSize.v14, color: color),
          AppSize.v4.w,
          label.text.labelSmall(context).semiBold.color(color).maxLine(1),
        ]
        .row(mainAxisSize: MainAxisSize.min)
        .paddingSymmetric(h: AppSize.v10, v: AppSize.v6)
        .container(
          color: color.withValues(alpha: 0.1),
          borderRadius: AppSize.v20,
          border: Border.all(color: color.withValues(alpha: 0.2)),
        );
  }
}
