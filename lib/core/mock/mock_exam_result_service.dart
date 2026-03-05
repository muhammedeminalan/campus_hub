import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/exam_result_fixture.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/exam_results/domain/i_exam_result_service.dart';

/// [IExamResultService] mock implementasyonu.
///
/// [BaseMockService] [getAll] ve [getById] boilerplate'ini karşılar;
/// burada yalnızca dönem metodları implement edilir.
///
/// Firebase'e geçince injection_container'da:
/// `MockExamResultService() → FirebaseExamResultService()`
class MockExamResultService extends BaseMockService<ExamResultModel>
    implements IExamResultService {
  MockExamResultService()
    : super(items: ExamResultFixture.results, idOf: (r) => r.id);

  @override
  Future<List<PeriodModel>> getPeriods() async => PeriodModel.mockList;

  @override
  Future<List<ExamResultModel>> getByPeriod(String periodId) async =>
      items.where((r) => r.periodId == periodId).toList();
}
