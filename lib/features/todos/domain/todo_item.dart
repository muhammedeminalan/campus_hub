import 'package:campus_hub/features/todos/domain/todo_priority.dart';
import 'package:equatable/equatable.dart';

/// Yapılacak görevin domain modeli.
/// Neden: Cubit, view ve mock servis aynı veri sözleşmesini paylaşsın.
final class TodoItem extends Equatable {
  static const _noChange = Object();

  const TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
    required this.category,
    this.dueDate,
  });

  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final TodoPriority priority;
  final bool isCompleted;
  final String category;

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    Object? dueDate = _noChange,
    TodoPriority? priority,
    bool? isCompleted,
    String? category,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate == _noChange ? this.dueDate : dueDate as DateTime?,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    dueDate,
    priority,
    isCompleted,
    category,
  ];
}
