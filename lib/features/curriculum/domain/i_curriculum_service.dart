import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';

/// Müfredat servisinin feature'a özel sözleşmesi.
///
/// [IService] üzerinden temel listeleme/alma operasyonlarını taşır,
/// ayrıca sınıf bazlı kategori listesini ve kategori bazlı müfredat sorgusunu sunar.
abstract interface class ICurriculumService
    implements IService<CurriculumModel> {
  /// Sistemdeki müfredatlarda geçen sınıf seviyelerini döner.
  Future<List<int>> getClassLevels();

  /// Belirli sınıf + dönem kombinasyonuna ait dersleri döner.
  Future<List<CurriculumModel>> getCurriculumsByCategory({
    required int classLevel,
    required int semester,
  });
}
