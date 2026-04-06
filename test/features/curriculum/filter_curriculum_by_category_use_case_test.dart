import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:campus_hub/features/curriculum/domain/usecases/filter_curriculum_by_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = FilterCurriculumByCategoryUseCase();

  final allCurriculums = [
    const CurriculumModel(
      id: '1',
      courseCode: 'YBS101',
      courseName: 'Giriş',
      classLevel: 1,
      semester: 1,
      credit: 3,
      akts: 5,
      isCompulsory: true,
    ),
    const CurriculumModel(
      id: '2',
      courseCode: 'YBS102',
      courseName: 'Programlama',
      classLevel: 1,
      semester: 2,
      credit: 4,
      akts: 6,
      isCompulsory: true,
    ),
    const CurriculumModel(
      id: '3',
      courseCode: 'YBS201',
      courseName: 'Veri Tabanı',
      classLevel: 2,
      semester: 1,
      credit: 4,
      akts: 6,
      isCompulsory: true,
    ),
  ];

  group('FilterCurriculumByCategoryUseCase', () {
    test('sınıf ve dönem null ise tüm müfredat döner', () {
      final result = useCase(allCurriculums, classLevel: null, semester: null);

      expect(result.length, 3);
    });

    test('sınıf + dönem eşleşirse sadece ilgili kayıtlar döner', () {
      final result = useCase(allCurriculums, classLevel: 1, semester: 2);

      expect(result.length, 1);
      expect(result.first.id, '2');
    });

    test('eşleşme yoksa boş liste döner', () {
      final result = useCase(allCurriculums, classLevel: 4, semester: 2);

      expect(result, isEmpty);
    });
  });
}
