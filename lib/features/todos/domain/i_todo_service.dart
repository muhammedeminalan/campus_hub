import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/todos/domain/todo_item.dart';

/// Yapılacaklar verisini sağlayan servis sözleşmesi.
/// Neden: mock ve gerçek data source aynı interface'i implement etsin.
abstract interface class ITodoService implements IService<TodoItem> {
  /// Tamamlanma durumuna göre filtrelenmiş görevleri döner.
  Future<List<TodoItem>> getByCompletion({required bool isCompleted});
}
