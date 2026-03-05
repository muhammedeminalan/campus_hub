import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:campus_hub/features/exam_results/domain/usecases/group_exam_results_by_course_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = GroupExamResultsByCourseUseCase();

  group('GroupExamResultsByCourseUseCase', () {
    test('boş liste → boş map döner', () {
      expect(useCase([]), isEmpty);
    });

    test('tek ders → map bir key içerir', () {
      final results = [
        const ExamResultModel(
          id: '1',
          courseTitle: 'Yazılım Müh.',
          examType: 'Vize',
          score: 70,
          letterGrade: 'BB',
          credit: 3,
          periodId: 'p1',
        ),
        const ExamResultModel(
          id: '2',
          courseTitle: 'Yazılım Müh.',
          examType: 'Final',
          score: 80,
          letterGrade: 'BB',
          credit: 3,
          periodId: 'p1',
        ),
      ];
      final grouped = useCase(results);
      expect(grouped.length, 1);
      expect(grouped['Yazılım Müh.']?.length, 2);
    });

    test('çok ders → her ders kendi grubunda', () {
      final results = [
        const ExamResultModel(
          id: '1',
          courseTitle: 'Yazılım Müh.',
          examType: 'Vize',
          score: 70,
          letterGrade: 'BB',
          credit: 3,
          periodId: 'p1',
        ),
        const ExamResultModel(
          id: '2',
          courseTitle: 'Veri Tabanı',
          examType: 'Vize',
          score: 90,
          letterGrade: 'AA',
          credit: 4,
          periodId: 'p1',
        ),
        const ExamResultModel(
          id: '3',
          courseTitle: 'Veri Tabanı',
          examType: 'Final',
          score: 95,
          letterGrade: 'AA',
          credit: 4,
          periodId: 'p1',
        ),
      ];
      final grouped = useCase(results);
      expect(grouped.length, 2);
      expect(grouped['Yazılım Müh.']?.length, 1);
      expect(grouped['Veri Tabanı']?.length, 2);
    });
  });
}
