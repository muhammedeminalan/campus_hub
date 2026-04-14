import 'package:campus_hub/features/todos/domain/todo_item.dart';
import 'package:campus_hub/features/todos/domain/todo_priority.dart';

/// Demo ortamında kullanılan yapılacak görev örnekleri.
/// Neden: gerçek backend yokken ekran davranışı tutarlı test edilsin.
abstract final class TodoFixture {
  static List<TodoItem> get items {
    final now = DateTime.now();

    return [
      TodoItem(
        id: 'todo-1',
        title: 'Algoritma ödevini sisteme yükle',
        description: 'PDF çıktısını OBS üzerinden yükleyip teslimi kapat.',
        dueDate: now.subtract(const Duration(days: 1)),
        priority: TodoPriority.high,
        isCompleted: false,
        category: 'Akademik',
      ),
      TodoItem(
        id: 'todo-2',
        title: 'Veri tabanı quiz tekrarını bitir',
        description: 'Normalization ve index konularını kısa notla pekiştir.',
        dueDate: now,
        priority: TodoPriority.high,
        isCompleted: false,
        category: 'Ders',
      ),
      TodoItem(
        id: 'todo-3',
        title: 'Danışmana staj formu maili at',
        description: 'Onay süreci uzamasın diye ekleri kontrol edip gönder.',
        dueDate: now.add(const Duration(days: 1)),
        priority: TodoPriority.medium,
        isCompleted: false,
        category: 'Akademik',
      ),
      TodoItem(
        id: 'todo-4',
        title: 'Mobil proje branch cleanup',
        description: 'Eski branchleri temizleyip açık işleri issueya taşı.',
        dueDate: now.add(const Duration(days: 3)),
        priority: TodoPriority.low,
        isCompleted: false,
        category: 'Proje',
      ),
      TodoItem(
        id: 'todo-5',
        title: 'Sınav haftası çalışma planı hazırla',
        description: 'Ders bazında blok süreleri çıkar ve takvime işle.',
        dueDate: now.subtract(const Duration(days: 2)),
        priority: TodoPriority.medium,
        isCompleted: true,
        category: 'Planlama',
      ),
      const TodoItem(
        id: 'todo-6',
        title: 'Flutter notlarını düzenle',
        description: 'BLoC akış örneklerini tek dosyada toparla.',
        dueDate: null,
        priority: TodoPriority.low,
        isCompleted: true,
        category: 'Kişisel',
      ),
    ];
  }
}
