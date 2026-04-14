part of 'todos_cubit.dart';

sealed class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

final class TodosInitial extends TodosState {
  const TodosInitial();
}

final class TodosLoading extends TodosState {
  const TodosLoading();
}

final class TodosLoaded extends TodosState {
  const TodosLoaded({
    required this.allTodos,
    required this.filteredTodos,
    required this.selectedFilter,
  });

  final List<TodoItem> allTodos;
  final List<TodoItem> filteredTodos;
  final TodoFilter selectedFilter;

  TodosLoaded copyWith({
    List<TodoItem>? allTodos,
    List<TodoItem>? filteredTodos,
    TodoFilter? selectedFilter,
  }) {
    return TodosLoaded(
      allTodos: allTodos ?? this.allTodos,
      filteredTodos: filteredTodos ?? this.filteredTodos,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [allTodos, filteredTodos, selectedFilter];
}

final class TodosError extends TodosState {
  const TodosError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
