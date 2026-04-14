import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/todo_priority.dart';
import 'package:campus_hub/features/todos/domain/usecases/filter_todos_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = FilterTodosUseCase();

  final now = DateTime(2026, 4, 14);

  final allTodos = [
    TodoItem(
      id: '1',
      title: 'Algoritma ödevi',
      description: 'Haftalık ödevi sisteme yükle',
      dueDate: DateTime(2026, 4, 12),
      priority: TodoPriority.high,
      isCompleted: false,
      category: 'Akademik',
    ),
    TodoItem(
      id: '2',
      title: 'Notları düzenle',
      description: 'Vize notlarını tabloya geçir',
      dueDate: DateTime(2026, 4, 15),
      priority: TodoPriority.medium,
      isCompleted: false,
      category: 'Ders',
    ),
    TodoItem(
      id: '3',
      title: 'Danışmana mail at',
      description: 'Staj onayı için mail gönder',
      dueDate: DateTime(2026, 4, 13),
      priority: TodoPriority.high,
      isCompleted: true,
      category: 'Akademik',
    ),
  ];

  group('FilterTodosUseCase', () {
    test('all filtresi tüm kayıtları döndürmeli', () {
      final result = useCase(allTodos, filter: TodoFilter.all, now: now);
      expect(result.length, 3);
    });

    test('pending filtresi sadece tamamlanmayanları döndürmeli', () {
      final result = useCase(allTodos, filter: TodoFilter.pending, now: now);
      expect(result.length, 2);
      expect(result.every((todo) => !todo.isCompleted), isTrue);
    });

    test('completed filtresi sadece tamamlananları döndürmeli', () {
      final result = useCase(allTodos, filter: TodoFilter.completed, now: now);
      expect(result.length, 1);
      expect(result.first.id, '3');
    });

    test('overdue filtresi sadece geciken ve tamamlanmayanları döndürmeli', () {
      final result = useCase(allTodos, filter: TodoFilter.overdue, now: now);
      expect(result.length, 1);
      expect(result.first.id, '1');
    });
  });
}
