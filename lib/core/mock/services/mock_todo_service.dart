import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/todo_fixture.dart';
import 'package:campus_hub/features/todos/domain/i_todo_service.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';

/// [ITodoService] mock implementasyonu.
/// Neden: backend hazır olmadan Cubit/view akışı gerçekçi veriyle doğrulansın.
class MockTodoService extends BaseMockService<TodoItem>
    implements ITodoService {
  MockTodoService() : super(items: TodoFixture.items, idOf: (todo) => todo.id);

  @override
  Future<List<TodoItem>> getByCompletion({required bool isCompleted}) async {
    return items.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}
