import 'package:campus_hub/features/todos/domain/i_todo_service.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/usecases/filter_todos_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit({required ITodoService service, FilterTodosUseCase? filterUseCase})
    : _service = service,
      _filterUseCase = filterUseCase ?? const FilterTodosUseCase(),
      super(const TodosInitial());

  final ITodoService _service;
  final FilterTodosUseCase _filterUseCase;

  /// Yapılacak görevlerini yükler.
  /// Neden: ekran açılışında filtre/sayım bilgileri tek state ile beslensin.
  Future<void> loadData() async {
    emit(const TodosLoading());

    try {
      final todos = await _service.getAll();
      final filtered = _filterUseCase(todos, filter: TodoFilter.all);

      emit(
        TodosLoaded(
          allTodos: todos,
          filteredTodos: filtered,
          selectedFilter: TodoFilter.all,
        ),
      );
    } catch (e, st) {
      debugPrint('TodosCubit.loadData hatası: $e\n$st');
      emit(TodosError(message: e.toString()));
    }
  }

  /// Kullanıcı filtre değiştirince görünür listeyi yeniden üretir.
  void selectFilter(TodoFilter filter) {
    final current = state;
    if (current is! TodosLoaded) return;

    final filtered = _filterUseCase(current.allTodos, filter: filter);
    emit(current.copyWith(selectedFilter: filter, filteredTodos: filtered));
  }

  /// Görev tamamlandı durumunu yerelde günceller.
  /// Neden: mock akışta kullanıcı etkileşimini beklemeden gösterebilmek.
  void toggleTodoStatus(String todoId) {
    final current = state;
    if (current is! TodosLoaded) return;

    final updatedTodos = current.allTodos
        .map(
          (todo) => todo.id == todoId
              ? todo.copyWith(isCompleted: !todo.isCompleted)
              : todo,
        )
        .toList();

    final filtered = _filterUseCase(
      updatedTodos,
      filter: current.selectedFilter,
    );

    emit(current.copyWith(allTodos: updatedTodos, filteredTodos: filtered));
  }
}
