import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/core/constants/app_sizes.dart';
import 'package:campus_hub/core/constants/app_strings.dart';
import 'package:campus_hub/features/todos/presentation/cubit/todos_cubit.dart';
import 'package:campus_hub/features/todos/presentation/widgets/todo_empty_state.dart';
import 'package:campus_hub/features/todos/presentation/widgets/todo_filter_chips.dart';
import 'package:campus_hub/features/todos/presentation/widgets/todo_item_card.dart';
import 'package:campus_hub/features/todos/presentation/widgets/todo_summary_card.dart';
import 'package:campus_hub/shared/widgets/app_bar/core_app_bar.dart';
import 'package:campus_hub/shared/widgets/errors/app_error_view.dart';
import 'package:campus_hub/shared/widgets/lists/app_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

/// Yapılacak görevlerini gösteren ana sayfa.
/// Neden: Quick Menu "Yapılacaklar" rotasını üretime hazır hale getirmek.
class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TodosCubit>(),
      child: const _TodosBody(),
    );
  }
}

class _TodosBody extends StatefulWidget {
  const _TodosBody();

  @override
  State<_TodosBody> createState() => _TodosBodyState();
}

class _TodosBodyState extends State<_TodosBody> {
  @override
  void initState() {
    super.initState();
    // IndexedStack ile geçişte tekrar istek yerine tek noktadan yükleme yönet.
    context.read<TodosCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(title: AppStrings.todos),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) => switch (state) {
          TodosInitial() ||
          TodosLoading() => const CircularProgressIndicator.adaptive().center,
          TodosError(:final message) => AppErrorView(
            message: AppStrings.todosLoadError,
            subMessage: message ?? AppStrings.todosLoadErrorSub,
            onRetry: () => context.read<TodosCubit>().loadData(),
          ),
          TodosLoaded() => _buildContent(state),
        },
      ),
    );
  }

  Widget _buildContent(TodosLoaded state) {
    return [
      TodoSummaryCard(
        todos: state.allTodos,
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v16),
      TodoFilterChips(
        selected: state.selectedFilter,
        onChanged: (filter) => context.read<TodosCubit>().selectFilter(filter),
      ).paddingOnly(left: AppSize.v16, right: AppSize.v16, top: AppSize.v12),
      _buildTodoList(state).expanded(),
    ].column(crossAxisAlignment: .start);
  }

  Widget _buildTodoList(TodosLoaded state) {
    return AppListView(
      items: state.filteredTodos,
      padding: const EdgeInsets.fromLTRB(
        AppSize.v16,
        AppSize.v12,
        AppSize.v16,
        AppSize.v24,
      ),
      emptyWidget: const TodoEmptyState(),
      itemBuilder: (context, todo, index) {
        return TodoItemCard(
          todo: todo,
          onToggle: () => context.read<TodosCubit>().toggleTodoStatus(todo.id),
        ).paddingOnly(bottom: AppSize.v12);
      },
    );
  }
}
