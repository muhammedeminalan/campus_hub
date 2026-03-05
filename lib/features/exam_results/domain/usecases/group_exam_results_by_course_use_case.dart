import 'package:campus_hub/core/models/exam_result_model.dart';

/// Sınav sonuçlarını ders adına göre gruplandıran use case.
///
/// Gruplama mantığı view'dan soyutlanır; testte izole edilebilir.
final class GroupExamResultsByCourseUseCase {
  const GroupExamResultsByCourseUseCase();

  /// [results] listesini ders adına göre gruplandırır.
  ///
  /// Döner: `{ courseTitle → [ExamResultModel, ...] }`
  Map<String, List<ExamResultModel>> call(List<ExamResultModel> results) {
    final map = <String, List<ExamResultModel>>{};
    for (final result in results) {
      map.putIfAbsent(result.courseTitle, () => []).add(result);
    }
    return map;
  }
}
