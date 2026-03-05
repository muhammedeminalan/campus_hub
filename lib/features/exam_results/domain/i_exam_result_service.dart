import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:campus_hub/core/models/period_model.dart';

/// Sınav sonuçları servisine özgü sözleşme.
///
/// [IService]'den [ExamResultModel] üzerinde temel CRUD operasyonlarını miras
/// alır; dönem filtrelemesi için ek metod ekler.
abstract interface class IExamResultService
    implements IService<ExamResultModel> {
  /// Tüm dönemleri döner.
  Future<List<PeriodModel>> getPeriods();

  /// Belirtilen döneme ait sınav sonuçlarını döner.
  Future<List<ExamResultModel>> getByPeriod(String periodId);
}
