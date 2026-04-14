import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/todo_priority.dart';
import 'package:flutter/material.dart';

/// Görev listesini seçili filtreye göre daraltır.
/// Neden: filtre davranışı view/cubit'ten izole edilip kolay testlensin.
enum TodoFilter { all, pending, completed, overdue }

final class FilterTodosUseCase {
  const FilterTodosUseCase();

  List<TodoItem> call(
    List<TodoItem> todos, {
    required TodoFilter filter,
    DateTime? now,
  }) {
    final today = DateUtils.dateOnly(now ?? DateTime.now());

    bool isOverdue(TodoItem todo) {
      final dueDate = todo.dueDate;
      if (todo.isCompleted || dueDate == null) return false;
      return DateUtils.dateOnly(dueDate).isBefore(today);
    }

    final filtered = todos.where((todo) {
      return switch (filter) {
        TodoFilter.all => true,
        TodoFilter.pending => !todo.isCompleted,
        TodoFilter.completed => todo.isCompleted,
        TodoFilter.overdue => isOverdue(todo),
      };
    }).toList();

    filtered.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }

      final aDue = a.dueDate;
      final bDue = b.dueDate;

      if (aDue == null && bDue != null) return 1;
      if (aDue != null && bDue == null) return -1;
      if (aDue != null && bDue != null) {
        final dueCompare = aDue.compareTo(bDue);
        if (dueCompare != 0) return dueCompare;
      }

      return _priorityWeight(b.priority).compareTo(_priorityWeight(a.priority));
    });

    return filtered;
  }

  int _priorityWeight(TodoPriority priority) {
    return switch (priority) {
      TodoPriority.low => 1,
      TodoPriority.medium => 2,
      TodoPriority.high => 3,
    };
  }
}
