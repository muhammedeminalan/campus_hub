import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/curriculum_fixture.dart';
import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';
import 'package:campus_hub/features/curriculum/domain/i_curriculum_service.dart';

/// [ICurriculumService] mock implementasyonu.
///
/// [BaseMockService] ortak getAll/getById davranışını sağladığı için burada
/// yalnızca müfredata özgü kategori metotları implement edilir.
class MockCurriculumService extends BaseMockService<CurriculumModel>
    implements ICurriculumService {
  MockCurriculumService()
    : super(items: CurriculumFixture.curriculums, idOf: (item) => item.id);

  @override
  Future<List<int>> getClassLevels() async {
    final classLevels =
        items.map((curriculum) => curriculum.classLevel).toSet().toList()
          ..sort();

    return classLevels;
  }

  @override
  Future<List<CurriculumModel>> getCurriculumsByCategory({
    required int classLevel,
    required int semester,
  }) async {
    return items
        .where(
          (curriculum) =>
              curriculum.classLevel == classLevel &&
              curriculum.semester == semester,
        )
        .toList();
  }
}
