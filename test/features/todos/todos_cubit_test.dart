import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/todos/domain/i_todo_service.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/todo_priority.dart';
import 'package:campus_hub/features/todos/domain/usecases/filter_todos_use_case.dart';
import 'package:campus_hub/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTodoService extends Mock implements ITodoService {}

void main() {
  late _MockTodoService mockService;
  late TodosCubit cubit;

  final tTodos = [
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
      title: 'Danışmana mail at',
      description: 'Staj onayı için mail gönder',
      dueDate: DateTime(2026, 4, 13),
      priority: TodoPriority.medium,
      isCompleted: true,
      category: 'Akademik',
    ),
  ];

  setUp(() {
    mockService = _MockTodoService();
    cubit = TodosCubit(
      service: mockService,
      filterUseCase: const FilterTodosUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('TodosCubit', () {
    blocTest<TodosCubit, TodosState>(
      'loadData başarılıysa [TodosLoading, TodosLoaded] emit etmeli',
      build: () {
        when(() => mockService.getAll()).thenAnswer((_) async => tTodos);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const TodosLoading(), isA<TodosLoaded>()],
    );

    blocTest<TodosCubit, TodosState>(
      'loadData hata alırsa [TodosLoading, TodosError] emit etmeli',
      build: () {
        when(() => mockService.getAll()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const TodosLoading(), isA<TodosError>()],
    );

    blocTest<TodosCubit, TodosState>(
      'selectFilter completed seçilince sadece tamamlanan görevler kalmalı',
      build: () {
        when(() => mockService.getAll()).thenAnswer((_) async => tTodos);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectFilter(TodoFilter.completed);
      },
      verify: (c) {
        final state = c.state as TodosLoaded;
        expect(state.selectedFilter, TodoFilter.completed);
        expect(state.filteredTodos.length, 1);
        expect(state.filteredTodos.first.id, '2');
      },
    );

    blocTest<TodosCubit, TodosState>(
      'toggleTodoStatus görev durumunu değiştirmeli',
      build: () {
        when(() => mockService.getAll()).thenAnswer((_) async => tTodos);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.toggleTodoStatus('1');
      },
      verify: (c) {
        final state = c.state as TodosLoaded;
        final updated = state.allTodos.firstWhere((todo) => todo.id == '1');
        expect(updated.isCompleted, isTrue);
      },
    );
  });
}
